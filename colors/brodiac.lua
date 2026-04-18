-- Brodiac colorscheme — ported from VSCode theme by Alex Tebbs.
-- Dark: Monokai-inspired black bg with yellow (#FFCC00) accents.
-- Light: GitHub-inspired white bg with tuned accents from settings.json.
-- Flip with `:set background=light` or `:set background=dark`, then re-source.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "brodiac"
vim.o.termguicolors = true

local is_light = vim.o.background == "light"

local c
if is_light then
  c = {
    bg           = "#FFFFFF",
    bg_alt       = "#f5f5f5",
    bg_line      = "#F1F1F1",
    bg_float     = "#FFFFFF",
    bg_visual    = "#FFCC00",
    fg           = "#24292E",
    fg_dim       = "#6A737D",
    fg_faint     = "#b3b3b3",
    border       = "#e1e4e8",
    indent       = "#eeeeee",
    cursor       = "#b5200d",
    accent       = "#0f4a85",
    yellow       = "#d17000",
    pmenu_sel    = "#e1eaf5",

    comment      = "#a96fa1",
    variable     = "#E36209",
    var_param    = "#4499c7",
    var_property = "#5c9abb",
    var_this     = "#FC9B1B",
    var_this_ts  = "#ff92ff",
    func         = "#6F42C1",
    type         = "#006d0d",
    keyword      = "#D73A49",
    keyword_alt  = "#000000",
    storage      = "#D73A49",
    string       = "#c48d5d",
    string_tpl   = "#c48d5d",
    string_regex = "#032F62",
    number       = "#005CC5",
    punct        = "#586069",
    tag          = "#22863A",
    tag_attr     = "#6F42C1",
    tag_delim    = "#24292E",
    primitive    = "#006d0d",
    unit         = "#6F42C1",

    error        = "#B31D28",
    warn         = "#895503",
    info         = "#005CC5",
    hint         = "#E36209",

    git_add      = "#22863A",
    git_change   = "#E36209",
    git_delete   = "#B31D28",
    diff_add     = "#dafbe1",
    diff_del     = "#ffebe9",
  }
else
  c = {
    bg           = "#000000",
    bg_alt       = "#080808",
    bg_line      = "#0a0c5f",
    bg_float     = "#17001d",
    bg_visual    = "#FFCC00",
    fg           = "#ffffff",
    fg_dim       = "#888888",
    fg_faint     = "#555555",
    border       = "#343434",
    indent       = "#111111",
    cursor       = "#FF00FF",
    accent       = "#43b9d8",
    yellow       = "#FFCC00",
    pmenu_sel    = "#1f5563",

    comment      = "#4D4D53",
    variable     = "#9CDCFE",
    var_param    = "#aee3ff",
    var_property = "#7ad0ff",
    var_this     = "#FC9B1B",
    var_this_ts  = "#ff92ff",
    func         = "#A6E22E",
    type         = "#66D9EF",
    keyword      = "#F92672",
    keyword_alt  = "#a3e2f7",
    storage      = "#AE81FF",
    string       = "#F9EC6D",
    string_tpl   = "#fff8b8",
    string_regex = "#D16969",
    number       = "#AE81FF",
    punct        = "#F3C6BE",
    tag          = "#F92672",
    tag_attr     = "#A6E22E",
    tag_delim    = "#5CDBEF",
    primitive    = "#FFCC00",
    unit         = "#9A73E4",

    error        = "#ff2a00",
    warn         = "#FFCC00",
    info         = "#3794ff",
    hint         = "#fd971f",

    git_add      = "#33ab4e",
    git_change   = "#009bf9",
    git_delete   = "#fc5d6d",
    diff_add     = "#10322e",
    diff_del     = "#491925",
  }
end

local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

-- Editor base
hl("Normal",        { fg = c.fg, bg = c.bg })
hl("NormalFloat",   { fg = c.fg, bg = c.bg_float })
hl("FloatBorder",   { fg = c.border, bg = c.bg_float })
hl("SignColumn",    { bg = c.bg })
hl("LineNr",        { fg = c.fg_faint, bg = c.bg })
hl("CursorLineNr",  { fg = c.yellow })
hl("ColorColumn",   {})
hl("CursorLine",    {})
hl("CursorColumn",  {})
hl("Cursor",        { fg = c.bg, bg = c.cursor })
hl("TermCursor",    { fg = c.bg, bg = c.cursor })
hl("MatchParen",    { fg = c.yellow, underline = true })
hl("Visual",        { fg = c.bg, bg = c.bg_visual })
hl("VisualNOS",     { fg = c.bg, bg = c.bg_visual })
hl("Search",        { fg = c.yellow, underline = true })
hl("IncSearch",     { fg = c.yellow, underline = true })
hl("CurSearch",     { fg = c.yellow, underline = true })
hl("Substitute",    { fg = c.yellow, underline = true })
hl("NonText",       { fg = c.border })
hl("Whitespace",    { fg = c.border })
hl("EndOfBuffer",   { fg = c.bg })
hl("SpecialKey",    { fg = c.border })
hl("Folded",        { fg = c.fg_dim })
hl("FoldColumn",    { fg = c.fg_faint })
hl("Conceal",       { fg = c.fg_dim })
hl("Directory",     { fg = c.accent })
hl("Title",         { fg = c.accent })
hl("ErrorMsg",      { fg = c.error })
hl("WarningMsg",    { fg = c.warn })
hl("ModeMsg",       { fg = c.yellow })
hl("MoreMsg",       { fg = c.accent })
hl("MsgArea",       { fg = c.fg, bg = c.bg })
hl("Question",      { fg = c.accent })
hl("QuickFixLine",  { fg = c.yellow })

-- Splits / statusline / tabs
hl("StatusLine",    { fg = c.yellow, bg = c.bg_alt })
hl("StatusLineNC",  { fg = c.fg_dim, bg = c.bg_alt })
hl("TabLine",       { fg = c.fg, bg = c.bg })
hl("TabLineSel",    { fg = c.yellow, bg = c.bg })
hl("TabLineFill",   { bg = c.bg })
hl("WinBar",        { fg = c.fg, bg = c.bg })
hl("WinBarNC",      { fg = c.fg_dim, bg = c.bg })
hl("WinSeparator",  { fg = c.border, bg = c.bg })
hl("VertSplit",     { fg = c.border, bg = c.bg })

-- Popup menu
hl("Pmenu",         { fg = c.fg, bg = c.bg })
hl("PmenuSel",      { bg = c.pmenu_sel, fg = c.fg })
hl("PmenuSbar",     { bg = c.bg })
hl("PmenuThumb",    { bg = c.border })
hl("PmenuKind",     { fg = c.accent, bg = c.bg })
hl("PmenuKindSel",  { fg = c.yellow, bg = c.pmenu_sel })
hl("PmenuExtra",    { fg = c.fg_dim, bg = c.bg })
hl("PmenuExtraSel", { fg = c.fg_dim, bg = c.pmenu_sel })
hl("WildMenu",      { fg = c.yellow, bg = c.pmenu_sel })

-- Spell
hl("SpellBad",      { sp = c.error, undercurl = true })
hl("SpellCap",      { sp = c.info, undercurl = true })
hl("SpellLocal",    { sp = c.hint, undercurl = true })
hl("SpellRare",     { sp = c.warn, undercurl = true })

-- ===== Syntax (vim legacy groups) =====
hl("Comment",       { fg = c.comment })
hl("Constant",      { fg = c.number })
hl("String",        { fg = c.string })
hl("Character",     { fg = c.string })
hl("Number",        { fg = c.number })
hl("Boolean",       { fg = c.number })
hl("Float",         { fg = c.number })
hl("Identifier",    { fg = c.variable })
hl("Function",      { fg = c.func })
hl("Statement",     { fg = c.keyword })
hl("Conditional",   { fg = c.keyword })
hl("Repeat",        { fg = c.keyword })
hl("Label",         { fg = c.keyword })
hl("Operator",      { fg = c.keyword })
hl("Keyword",       { fg = c.keyword })
hl("Exception",     { fg = c.keyword })
hl("PreProc",       { fg = c.keyword })
hl("Include",       { fg = c.keyword })
hl("Define",        { fg = c.keyword })
hl("Macro",         { fg = c.keyword })
hl("PreCondit",     { fg = c.keyword })
hl("Type",          { fg = c.type })
hl("StorageClass",  { fg = c.storage })
hl("Structure",     { fg = c.type })
hl("Typedef",       { fg = c.type })
hl("Special",       { fg = c.keyword })
hl("SpecialChar",   { fg = c.string_tpl })
hl("SpecialComment",{ fg = c.comment })
hl("Tag",           { fg = c.tag })
hl("Delimiter",     { fg = c.punct })
hl("Debug",         { fg = c.hint })
hl("Underlined",    { underline = true })
hl("Ignore",        { fg = c.fg_dim })
hl("Error",         { fg = c.error })
hl("Todo",          { fg = c.yellow })

-- ===== Treesitter =====
hl("@comment",                 { link = "Comment" })
hl("@comment.documentation",   { link = "Comment" })
hl("@comment.todo",            { link = "Todo" })
hl("@comment.error",           { fg = c.error })
hl("@comment.warning",         { fg = c.warn })
hl("@comment.note",            { fg = c.info })

hl("@string",                  { fg = c.string })
hl("@string.documentation",    { fg = c.string })
hl("@string.regexp",           { fg = c.string_regex })
hl("@string.escape",           { fg = c.string_tpl })
hl("@string.special",          { fg = c.string_tpl })
hl("@string.special.url",      { fg = c.accent, underline = true })

hl("@character",               { fg = c.string })
hl("@number",                  { fg = c.number })
hl("@number.float",            { fg = c.number })
hl("@boolean",                 { fg = c.number })
hl("@constant",                { fg = c.number })
hl("@constant.builtin",        { fg = c.number })
hl("@constant.macro",          { fg = c.number })

hl("@variable",                { fg = c.variable })
hl("@variable.builtin",        { fg = c.var_this })
hl("@variable.parameter",      { fg = c.var_param })
hl("@variable.member",         { fg = c.var_property })

hl("@property",                { fg = c.var_property })
hl("@field",                   { fg = c.var_property })

hl("@function",                { fg = c.func })
hl("@function.call",           { fg = c.func })
hl("@function.builtin",        { fg = c.func })
hl("@function.macro",          { fg = c.func })
hl("@function.method",         { fg = c.func })
hl("@function.method.call",    { fg = c.func })
hl("@method",                  { fg = c.func })
hl("@method.call",             { fg = c.func })
hl("@constructor",             { fg = c.func })

hl("@keyword",                 { fg = c.keyword })
hl("@keyword.function",        { fg = c.keyword })
hl("@keyword.operator",        { fg = c.keyword })
hl("@keyword.import",          { fg = c.keyword })
hl("@keyword.return",          { fg = c.keyword })
hl("@keyword.conditional",     { fg = c.keyword })
hl("@keyword.repeat",          { fg = c.keyword })
hl("@keyword.exception",       { fg = c.keyword })
hl("@keyword.storage",         { fg = c.storage })
hl("@keyword.coroutine",       { fg = c.keyword })
hl("@keyword.type",            { fg = c.keyword })
hl("@keyword.modifier",        { fg = c.keyword })

hl("@operator",                { fg = c.keyword })

hl("@type",                    { fg = c.type })
hl("@type.builtin",            { fg = c.primitive })
hl("@type.definition",         { fg = c.type })
hl("@type.qualifier",          { fg = c.keyword })

hl("@attribute",               { fg = c.func })
hl("@namespace",               { fg = c.primitive })

hl("@punctuation",             { fg = c.punct })
hl("@punctuation.delimiter",   { fg = c.punct })
hl("@punctuation.bracket",     { fg = c.punct })
hl("@punctuation.special",     { fg = c.keyword })

hl("@tag",                     { fg = c.tag })
hl("@tag.builtin",             { fg = c.tag })
hl("@tag.attribute",           { fg = c.tag_attr })
hl("@tag.delimiter",           { fg = c.tag_delim })

hl("@label",                   { fg = c.keyword })
hl("@module",                  { fg = c.primitive })
hl("@module.builtin",          { fg = c.primitive })

-- Language-specific nudges (from VSCode grammar rules)
hl("@variable.builtin.typescript",           { fg = c.var_this_ts })
hl("@variable.builtin.typescriptreact",      { fg = c.var_this_ts })
hl("@keyword.other",                         { fg = c.keyword_alt })
hl("@string.template",                       { fg = c.string_tpl })

-- Go-specific
hl("@keyword.type.go",         { fg = c.type })
hl("@keyword.function.go",     { fg = c.keyword })
hl("@type.go",                 { fg = c.type })

-- CSS/SCSS
hl("@property.css",            { fg = c.primitive })
hl("@type.css",                { fg = c.primitive })
hl("@number.css",              { fg = c.number })
hl("@keyword.unit.css",        { fg = c.unit })
hl("cssUnitDecorators",        { fg = c.unit })

-- ===== LSP semantic tokens =====
hl("@lsp.type.interface",      { fg = c.primitive })
hl("@lsp.type.type",           { fg = c.primitive })
hl("@lsp.type.namespace",      { fg = c.primitive })
hl("@lsp.type.class",          { fg = c.func })
hl("@lsp.type.enum",           { fg = c.type })
hl("@lsp.type.struct",         { fg = c.type })
hl("@lsp.type.typeParameter",  { fg = c.type })
hl("@lsp.type.parameter",      { fg = c.var_param })
hl("@lsp.type.property",       { fg = c.var_property })
hl("@lsp.type.variable",       { fg = c.variable })
hl("@lsp.type.function",       { fg = c.func })
hl("@lsp.type.method",         { fg = c.func })
hl("@lsp.type.keyword",        { fg = c.keyword })
hl("@lsp.type.operator",       { fg = c.keyword })
hl("@lsp.type.string",         { fg = c.string })
hl("@lsp.type.number",         { fg = c.number })
hl("@lsp.type.comment",        { link = "Comment" })
hl("@lsp.mod.readonly",        { fg = c.number })
hl("@lsp.mod.defaultLibrary",  { fg = c.var_this })

-- ===== Diagnostics =====
hl("DiagnosticError",          { fg = c.error })
hl("DiagnosticWarn",           { fg = c.warn })
hl("DiagnosticInfo",           { fg = c.info })
hl("DiagnosticHint",           { fg = c.hint })
hl("DiagnosticOk",             { fg = c.func })
hl("DiagnosticUnderlineError", { sp = c.error, undercurl = true })
hl("DiagnosticUnderlineWarn",  { sp = c.warn, undercurl = true })
hl("DiagnosticUnderlineInfo",  { sp = c.info, undercurl = true })
hl("DiagnosticUnderlineHint",  { sp = c.hint, undercurl = true })
hl("DiagnosticVirtualTextError", { fg = c.error })
hl("DiagnosticVirtualTextWarn",  { fg = c.warn })
hl("DiagnosticVirtualTextInfo",  { fg = c.info })
hl("DiagnosticVirtualTextHint",  { fg = c.hint })

-- ===== Diff / Git =====
hl("DiffAdd",          { bg = c.diff_add })
hl("DiffChange",       { bg = c.diff_add })
hl("DiffDelete",       { bg = c.diff_del })
hl("DiffText",         { bg = is_light and "#aceebb" or "#21635c" })
hl("diffAdded",        { fg = c.git_add })
hl("diffRemoved",      { fg = c.git_delete })
hl("diffChanged",      { fg = c.git_change })

hl("GitSignsAdd",      { fg = c.git_add })
hl("GitSignsChange",   { fg = c.git_change })
hl("GitSignsDelete",   { fg = c.git_delete })
hl("GitSignsAddLn",    { bg = c.diff_add })
hl("GitSignsChangeLn", { bg = c.diff_add })
hl("GitSignsDeleteLn", { bg = c.diff_del })
hl("GitSignsCurrentLineBlame", { fg = c.comment })

-- ===== Telescope =====
hl("TelescopeNormal",           { fg = c.fg, bg = c.bg })
hl("TelescopeBorder",           { fg = c.border, bg = c.bg })
hl("TelescopePromptNormal",     { fg = c.fg, bg = c.bg })
hl("TelescopePromptBorder",     { fg = c.accent, bg = c.bg })
hl("TelescopePromptTitle",      { fg = c.yellow, bg = c.bg })
hl("TelescopePromptPrefix",     { fg = c.accent, bg = c.bg })
hl("TelescopeResultsNormal",    { fg = c.fg, bg = c.bg })
hl("TelescopeResultsBorder",    { fg = c.border, bg = c.bg })
hl("TelescopeResultsTitle",     { fg = c.accent, bg = c.bg })
hl("TelescopePreviewNormal",    { fg = c.fg, bg = c.bg })
hl("TelescopePreviewBorder",    { fg = c.border, bg = c.bg })
hl("TelescopePreviewTitle",     { fg = c.accent, bg = c.bg })
hl("TelescopeSelection",        { fg = c.yellow, bg = c.bg_line })
hl("TelescopeSelectionCaret",   { fg = c.yellow, bg = c.bg_line })
hl("TelescopeMultiSelection",   { fg = c.func })
hl("TelescopeMatching",         { fg = c.yellow })

-- ===== Neo-tree =====
hl("NeoTreeNormal",             { fg = c.fg, bg = c.bg })
hl("NeoTreeNormalNC",           { fg = c.fg, bg = c.bg })
hl("NeoTreeTitleBar",           { fg = c.accent, bg = c.bg })
hl("NeoTreeRootName",           { fg = c.accent })
hl("NeoTreeDirectoryName",      { fg = c.fg })
hl("NeoTreeDirectoryIcon",      { fg = c.accent })
hl("NeoTreeFileName",           { fg = c.fg })
hl("NeoTreeIndentMarker",       { fg = c.indent })
hl("NeoTreeGitAdded",           { fg = c.git_add })
hl("NeoTreeGitModified",        { fg = c.git_change })
hl("NeoTreeGitDeleted",         { fg = c.git_delete })
hl("NeoTreeGitUntracked",       { fg = c.git_add })
hl("NeoTreeGitIgnored",         { fg = c.comment })
hl("NeoTreeCursorLine",         { bg = c.bg_line })

-- ===== Lualine =====
hl("lualine_a_normal",  { fg = c.bg, bg = c.accent })
hl("lualine_a_insert",  { fg = c.bg, bg = c.func })
hl("lualine_a_visual",  { fg = c.bg, bg = c.yellow })
hl("lualine_a_replace", { fg = c.fg, bg = c.error })
hl("lualine_a_command", { fg = c.bg, bg = c.var_this })

-- ===== nvim-cmp =====
hl("CmpItemAbbr",                { fg = c.fg })
hl("CmpItemAbbrDeprecated",      { fg = c.fg_dim, strikethrough = true })
hl("CmpItemAbbrMatch",           { fg = c.yellow })
hl("CmpItemAbbrMatchFuzzy",      { fg = c.yellow })
hl("CmpItemKind",                { fg = c.accent })
hl("CmpItemKindFunction",        { fg = c.func })
hl("CmpItemKindMethod",          { fg = c.func })
hl("CmpItemKindVariable",        { fg = c.variable })
hl("CmpItemKindField",           { fg = c.var_property })
hl("CmpItemKindClass",           { fg = c.type })
hl("CmpItemKindInterface",       { fg = c.primitive })
hl("CmpItemKindKeyword",         { fg = c.keyword })
hl("CmpItemMenu",                { fg = c.fg_dim })

-- ===== Notify =====
hl("NotifyERRORBorder",  { fg = c.error })
hl("NotifyWARNBorder",   { fg = c.warn })
hl("NotifyINFOBorder",   { fg = c.info })
hl("NotifyDEBUGBorder",  { fg = c.hint })
hl("NotifyTRACEBorder",  { fg = c.hint })
hl("NotifyERRORTitle",   { fg = c.error })
hl("NotifyWARNTitle",    { fg = c.warn })
hl("NotifyINFOTitle",    { fg = c.info })

-- ===== Markdown =====
hl("@markup.heading",             { fg = c.yellow })
hl("@markup.heading.1.markdown",  { fg = c.yellow })
hl("@markup.heading.2.markdown",  { fg = c.accent })
hl("@markup.heading.3.markdown",  { fg = c.func })
hl("@markup.link",                { fg = c.accent, underline = true })
hl("@markup.link.url",            { fg = c.accent, underline = true })
hl("@markup.link.label",          { fg = c.accent })
hl("@markup.raw",                 { fg = c.string })
hl("@markup.raw.block",           { fg = c.string })
hl("@markup.list",                { fg = c.keyword })
hl("@markup.italic",              {})
hl("@markup.strong",              {})
hl("@markup.quote",               { fg = c.comment })

-- ===== Harpoon =====
hl("HarpoonBorder",      { fg = c.accent, bg = c.bg })
hl("HarpoonWindow",      { fg = c.fg, bg = c.bg })
hl("HarpoonTitle",       { fg = c.yellow, bg = c.bg })

-- ===== Illuminate =====
hl("IlluminatedWordText",  { underline = true })
hl("IlluminatedWordRead",  { underline = true })
hl("IlluminatedWordWrite", { underline = true })
