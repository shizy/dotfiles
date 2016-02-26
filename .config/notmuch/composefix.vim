ruby << EOF
	def open_compose_helper(lines, cur)
		help_lines = [
			'',
			'',
			'',
			]

		dir = File.expand_path('/tmp')
		FileUtils.mkdir_p(dir)
		Tempfile.open(['nm-', '.mail'], dir) do |f|
			f.puts(help_lines)
			f.puts
			f.puts(lines)

			sig_file = File.expand_path('~/.signature')
			if File.exists?(sig_file)
				f.puts("-- ")
				f.write(File.read(sig_file))
			end

			f.flush

			cur += help_lines.size + 1

			VIM::command("let s:reply_from='%s'" % $email_address)
			VIM::command("call s:new_file_buffer('compose', '#{f.path}')")
			VIM::command("call cursor(#{cur}, 0)")
		end
	end

	def open_reply(orig)
		reply = orig.reply do |m|
			# fix headers
			if not m[:reply_to]
				m.to = [orig[:from].to_s]
			end
			m.cc = orig[:cc]
			m.from = $email
			m.charset = 'utf-8'
		end

		lines = []

		body_lines = []
		if $mail_installed
			addr = Mail::Address.new(orig[:from].value)
			name = addr.name
			name = addr.local + "@" if name.nil? && !addr.local.nil?
		else
			name = orig[:from]
		end
		name = "somebody" if name.nil?

		body_lines << "%s wrote:" % name
		part = orig.find_first_text
		part.convert.each_line do |l|
			body_lines << "> %s" % l.chomp
		end
		body_lines << ""
		body_lines << ""
		body_lines << ""

		reply.body = body_lines.join("\n")

		lines += reply.present.lines.map { |e| e.chomp }
		lines << ""

		cur = lines.count - 1

		open_compose_helper(lines, cur)
	end
EOF
