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
EOF
