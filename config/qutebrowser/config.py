import os

c.completion.height = "33%"
c.completion.scrollbar.width = 0
c.completion.shrink = True
c.force_software_rendering = True
c.hints.border = "1px solid " + os.environ["COLOR_DARK"]
c.hints.uppercase = True
c.input.spatial_navigation = True
c.tabs.favicons.show = False
c.tabs.last_close = "startpage"
c.tabs.show = "multiple"
c.tabs.title.format = "{title}"
c.tabs.title.format_pinned = "'{title}'"
c.tabs.width.indicator = 0
c.window.hide_wayland_decoration = True

c.fonts.monospace = os.environ["FONT_MONO"]

config.bind("<Alt-p>", "insert-text {primary}")
config.bind("<Alt-p>", "insert-text {primary}", mode="insert")
config.bind("<Alt-f>", "hint all tab-bg")
config.bind("<Alt-Shift-h>", "tab-prev")
config.bind("<Alt-Shift-l>", "tab-next")
config.bind("<Alt-x>", "tab-close")
config.bind("<Alt-o>", "set-cmd-text -s :open -t")
config.bind("<Alt-Shift-o>", "set-cmd-text -s :open -t {url}")
config.bind("<Alt-j>", "scroll-page 0 0.5", force=True)
config.bind("<Alt-k>", "scroll-page 0 -0.5", force=True)
config.bind("<Alt-u>", "forward")
config.bind("u", "back", force=True)
config.bind("<Alt-Shift-r>", "undo")
config.bind("<Alt-r>", "reload")
config.bind("<Alt-.>", "navigate next")
config.bind("<Alt-,>", "navigate prev")

c.colors.completion.fg = os.environ["COLOR_DARK_OFFSET"]
c.colors.completion.match.fg = os.environ["COLOR_NORMAL"]
c.colors.completion.category.bg = os.environ["COLOR_DARK"]
c.colors.completion.category.fg = os.environ["COLOR_NOTIFY"]
c.colors.completion.even.bg = os.environ["COLOR_DARK"]
c.colors.completion.odd.bg = os.environ["COLOR_DARK"]
c.colors.completion.item.selected.bg = os.environ["COLOR_DARK_OFFSET"]
c.colors.completion.item.selected.fg = os.environ["COLOR_NORMAL"]
c.colors.completion.item.selected.border.top = os.environ["COLOR_DARK"]
c.colors.completion.item.selected.border.bottom = os.environ["COLOR_DARK"]
c.colors.completion.scrollbar.bg = os.environ["COLOR_DARK"]
c.colors.completion.scrollbar.fg = os.environ["COLOR_DARK"]

c.colors.hints.bg = os.environ["COLOR_DARK"]
c.colors.hints.fg = os.environ["COLOR_URGENT"]
c.colors.hints.match.fg = os.environ["COLOR_NORMAL"]

c.colors.prompts.bg = os.environ["COLOR_DARK"]
c.colors.prompts.fg = os.environ["COLOR_DARK_OFFSET"]
c.colors.prompts.border = os.environ["COLOR_URGENT"]

c.colors.statusbar.command.bg = os.environ["COLOR_DARK"]
c.colors.statusbar.caret.bg = os.environ["COLOR_NOTIFY"]
c.colors.statusbar.caret.fg = os.environ["COLOR_DARK"]
c.colors.statusbar.insert.bg = os.environ["COLOR_URGENT"]
c.colors.statusbar.insert.fg = os.environ["COLOR_DARK"]
c.colors.statusbar.command.bg = os.environ["COLOR_DARK"]
c.colors.statusbar.command.fg = os.environ["COLOR_NORMAL"]
c.colors.statusbar.normal.bg = os.environ["COLOR_DARK"]
c.colors.statusbar.normal.fg = os.environ["COLOR_DARK_OFFSET"]
c.colors.statusbar.progress.bg = os.environ["COLOR_NORMAL"]
c.colors.statusbar.url.fg = os.environ["COLOR_DARK_OFFSET"]
c.colors.statusbar.url.hover.fg = os.environ["COLOR_DARK_OFFSET"]
c.colors.statusbar.url.error.fg = os.environ["COLOR_DARK_OFFSET"]
c.colors.statusbar.url.success.http.fg = os.environ["COLOR_DARK_OFFSET"]
c.colors.statusbar.url.success.https.fg = os.environ["COLOR_DARK_OFFSET"]
c.colors.statusbar.url.warn.fg = os.environ["COLOR_DARK_OFFSET"]

c.colors.tabs.bar.bg = os.environ["COLOR_DARK"]
c.colors.tabs.even.bg = os.environ["COLOR_DARK"]
c.colors.tabs.odd.bg = os.environ["COLOR_DARK"]
c.colors.tabs.even.fg = os.environ["COLOR_DARK_OFFSET"]
c.colors.tabs.odd.fg = os.environ["COLOR_DARK_OFFSET"]
c.colors.tabs.selected.even.fg = os.environ["COLOR_DARK"]
c.colors.tabs.selected.odd.fg = os.environ["COLOR_DARK"]
c.colors.tabs.selected.even.bg = os.environ["COLOR_DARK_OFFSET"]
c.colors.tabs.selected.odd.bg = os.environ["COLOR_DARK_OFFSET"]
