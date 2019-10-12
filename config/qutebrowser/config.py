import os

c.content.pdfjs = True
c.completion.height = "33%"
c.completion.scrollbar.width = 0
c.completion.shrink = True
c.completion.web_history.max_items = 100
c.downloads.location.directory = "/home/" + os.environ["USER"] + "/downloads/"
c.downloads.location.prompt = False
c.downloads.remove_finished = 5000
c.qt.force_software_rendering = 'none'
c.hints.border = "1px solid " + os.environ["COLOR_DARK"]
c.hints.uppercase = True
c.input.spatial_navigation = False
c.input.insert_mode.auto_load = True
c.tabs.favicons.show = "pinned"
c.tabs.last_close = "startpage"
c.tabs.show = "multiple"
c.tabs.title.format = "{current_title}"
c.tabs.title.format_pinned = ""
c.tabs.indicator.width = 0
c.tabs.new_position.related = "last"
c.tabs.new_position.unrelated = "last"
c.window.hide_decoration = True
c.input.insert_mode.auto_load = False

c.fonts.monospace = os.environ["FONT_MONO"]
c.fonts.completion.category = "bold " + os.environ["FONT_SIZE"] + "pt monospace"
c.fonts.completion.entry = os.environ["FONT_SIZE"] + "pt monospace"
c.fonts.debug_console = os.environ["FONT_SIZE"] + "pt monospace"
c.fonts.downloads = os.environ["FONT_SIZE"] + "pt monospace"
c.fonts.hints = "bold " + os.environ["FONT_SIZE"] + "pt monospace"
c.fonts.keyhint = os.environ["FONT_SIZE"] + "pt monospace"
c.fonts.messages.error = os.environ["FONT_SIZE"] + "pt monospace"
c.fonts.messages.info = os.environ["FONT_SIZE"] + "pt monospace"
c.fonts.messages.warning = os.environ["FONT_SIZE"] + "pt monospace"
c.fonts.prompts = os.environ["FONT_SIZE"] + "pt monospace"
c.fonts.statusbar = os.environ["FONT_SIZE"] + "pt monospace"
c.fonts.tabs = os.environ["FONT_SIZE"] + "pt monospace"

config.unbind("d", mode='normal')

config.bind("jj", "enter-mode normal", mode="insert")
config.bind("<Alt-/>", "spawn --userscript qute-bitwarden")
config.bind("<Alt-/>", "enter-mode normal ;; spawn --userscript qute-bitwarden", mode="insert")
config.bind("<Alt-p>", "insert-text {primary}")
config.bind("<Alt-p>", "insert-text {primary}", mode="insert")
config.bind("<Alt-f>", "hint all tab-bg")
config.bind("<Alt-n>", "search-prev")
config.bind("<Alt-Shift-h>", "tab-prev")
config.bind("<Alt-Shift-l>", "tab-next")
config.bind("<Alt-x>", "tab-close")
config.bind("<Alt-o>", "set-cmd-text -s :open -t")
config.bind("<Alt-Shift-o>", "set-cmd-text -s :open -t {url}")
config.bind("<Alt-j>", "scroll-page 0 0.5")
config.bind("<Alt-k>", "scroll-page 0 -0.5")
config.bind("<Alt-u>", "forward")
config.bind("<Alt-v>", "tab-pin")
config.bind("u", "back")
config.bind("<Alt-Shift-r>", "undo")
config.bind("<Alt-r>", "reload")
config.bind("<Alt-l>", "navigate next")
config.bind("<Alt-h>", "navigate prev")
config.bind("<Alt-j>", "completion-item-focus next", mode="command")
config.bind("<Alt-k>", "completion-item-focus prev", mode="command")
config.bind("<Alt-h>", "rl-backward-word", mode="command")
config.bind("<Alt-l>", "rl-forward-word", mode="command")
config.bind("<Alt-x>", "rl-kill-word", mode="command")
config.bind("<Alt-Shift-Ctrl-h>", "tab-move -");
config.bind("<Alt-Shift-Ctrl-l>", "tab-move +");
config.bind("<Alt-Tab>", "tab-focus last");
config.bind("<Alt-Space>", "set-cmd-text -s :buffer ");

c.colors.completion.fg = os.environ["COLOR_MEDIUM"]
c.colors.completion.match.fg = os.environ["COLOR_ACCENT"]
c.colors.completion.category.bg = os.environ["COLOR_DARK"]
c.colors.completion.category.fg = os.environ["COLOR_LIGHT"]
c.colors.completion.even.bg = os.environ["COLOR_DARK"]
c.colors.completion.odd.bg = os.environ["COLOR_DARK"]
c.colors.completion.item.selected.bg = os.environ["COLOR_MEDIUM"]
c.colors.completion.item.selected.fg = os.environ["COLOR_LIGHT"]
c.colors.completion.item.selected.border.top = os.environ["COLOR_DARK"]
c.colors.completion.item.selected.border.bottom = os.environ["COLOR_DARK"]
c.colors.completion.scrollbar.bg = os.environ["COLOR_DARK"]
c.colors.completion.scrollbar.fg = os.environ["COLOR_DARK"]

c.colors.hints.bg = os.environ["COLOR_DARK"]
c.colors.hints.fg = os.environ["COLOR_ACCENT"]
c.colors.hints.match.fg = os.environ["COLOR_LIGHT"]

c.colors.prompts.bg = os.environ["COLOR_ACCENT"]
c.colors.prompts.fg = os.environ["COLOR_DARK"]
c.colors.prompts.border = os.environ["COLOR_DARK"]

c.colors.statusbar.command.bg = os.environ["COLOR_DARK"]
c.colors.statusbar.caret.bg = os.environ["COLOR_LIGHT"]
c.colors.statusbar.caret.fg = os.environ["COLOR_DARK"]
c.colors.statusbar.insert.bg = os.environ["COLOR_ACCENT"]
c.colors.statusbar.insert.fg = os.environ["COLOR_DARK"]
c.colors.statusbar.command.bg = os.environ["COLOR_DARK"]
c.colors.statusbar.command.fg = os.environ["COLOR_LIGHT"]
c.colors.statusbar.normal.bg = os.environ["COLOR_DARK"]
c.colors.statusbar.normal.fg = os.environ["COLOR_MEDIUM"]
c.colors.statusbar.progress.bg = os.environ["COLOR_LIGHT"]
c.colors.statusbar.url.fg = os.environ["COLOR_MEDIUM"]
c.colors.statusbar.url.hover.fg = os.environ["COLOR_MEDIUM"]
c.colors.statusbar.url.error.fg = os.environ["COLOR_MEDIUM"]
c.colors.statusbar.url.success.http.fg = os.environ["COLOR_MEDIUM"]
c.colors.statusbar.url.success.https.fg = os.environ["COLOR_MEDIUM"]
c.colors.statusbar.url.warn.fg = os.environ["COLOR_MEDIUM"]

c.colors.tabs.bar.bg = os.environ["COLOR_DARK"]
c.colors.tabs.even.bg = os.environ["COLOR_DARK"]
c.colors.tabs.odd.bg = os.environ["COLOR_DARK"]
c.colors.tabs.even.fg = os.environ["COLOR_MEDIUM"]
c.colors.tabs.odd.fg = os.environ["COLOR_MEDIUM"]
c.colors.tabs.pinned.even.bg = os.environ["COLOR_DARK"]
c.colors.tabs.pinned.odd.bg = os.environ["COLOR_DARK"]
c.colors.tabs.pinned.even.fg = os.environ["COLOR_MEDIUM"]
c.colors.tabs.pinned.odd.fg = os.environ["COLOR_MEDIUM"]
c.colors.tabs.selected.even.fg = os.environ["COLOR_DARK"]
c.colors.tabs.selected.odd.fg = os.environ["COLOR_DARK"]
c.colors.tabs.selected.even.bg = os.environ["COLOR_MEDIUM"]
c.colors.tabs.selected.odd.bg = os.environ["COLOR_MEDIUM"]
c.colors.tabs.pinned.selected.even.fg = os.environ["COLOR_DARK"]
c.colors.tabs.pinned.selected.odd.fg = os.environ["COLOR_DARK"]
c.colors.tabs.pinned.selected.even.bg = os.environ["COLOR_MEDIUM"]
c.colors.tabs.pinned.selected.odd.bg = os.environ["COLOR_MEDIUM"]
