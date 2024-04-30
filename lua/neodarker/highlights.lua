local p = require("neodarker.palette")
local utils = require("neodarker.utils")
local config = require("neodarker.config")
local terminal = require("neodarker.terminal")

local M = {}

local function load_highlights(highlights)
    for group_name, group_settings in pairs(highlights) do
        vim.api.nvim_set_hl(0, group_name, group_settings)
    end
end

local styles = vim.tbl_map(function(value)
    return setmetatable(value, {
        __add = function(a, b)
            return vim.tbl_extend("force", a, b)
        end,
    })
end, config.styles)

local transparent_bg = setmetatable({}, {
    __add = function(a)
        a.bg = config.transparent_background and p.none or a.bg
        return a
    end,
})

local function gamma(value)
    return setmetatable({}, {
        __add = function(a)
            return utils.color_gamma(a, value)
        end,
    })
end

M.highlights = {
    Fg = { fg = p.fg },
    Grey = { fg = p.grey },
    Red = { fg = p.red },
    Orange = { fg = p.orange },
    Yellow = { fg = p.yellow },
    Green = { fg = p.green },
    Blue = { fg = p.blue },
    Purple = { fg = p.purple },
    Normal = { fg = p.fg, bg = p.bg0 } + transparent_bg,
    NormalNC = { fg = p.fg, bg = p.bg0 } + transparent_bg,
    NormalSB = { fg = p.fg, bg = p.bg0 } + transparent_bg,
    NormalFloat = { fg = p.fg, bg = p.bg0 } + transparent_bg,
    Terminal = { fg = p.fg, bg = p.bg0 } + transparent_bg,
    EndOfBuffer = { fg = p.bg2, bg = p.bg0 } + transparent_bg,
    FoldColumn = { fg = p.fg, bg = p.bg1 } + transparent_bg,
    Folded = { fg = p.fg, bg = p.bg1 } + transparent_bg,
    SignColumn = { fg = p.fg, bg = p.bg0 } + transparent_bg,
    ToolbarLine = { fg = p.fg },
    Cursor = { reverse = true },
    vCursor = { reverse = true },
    iCursor = { reverse = true },
    lCursor = { reverse = true },
    CursorIM = { reverse = true },
    CursorColumn = { bg = p.bg1 },
    CursorLine = { bg = p.bg1 },
    ColorColumn = { bg = p.bg1 },
    CursorLineNr = { fg = p.fg },
    LineNr = { fg = p.bg4 },
    Conceal = { fg = p.grey, bg = p.bg1 } + transparent_bg,
    DiffAdd = { fg = p.none, bg = p.diff_add },
    DiffChange = { fg = p.none, bg = p.diff_change },
    DiffDelete = { fg = p.none, bg = p.diff_delete },
    DiffText = { fg = p.none, bg = p.diff_text },
    Directory = { fg = p.green },
    ErrorMsg = { fg = p.red },
    WarningMsg = { fg = p.yellow },
    MoreMsg = { fg = p.blue },
    IncSearch = { fg = p.bg0, bg = p.bg_red },
    Search = { fg = p.bg0, bg = p.bg_green },
    CurSearch = { fg = p.bg0, bg = p.bg_red },
    MatchParen = { fg = p.none, bg = p.bg4 },
    NonText = { fg = p.bg4 },
    Whitespace = { fg = p.bg4 },
    SpecialKey = { fg = p.bg4 },
    Pmenu = { fg = p.fg, bg = p.bg0 },
    PmenuSbar = { fg = p.none, bg = p.bg0 },
    PmenuSel = { fg = p.bg0, bg = p.bg_green },
    PmenuThumb = { fg = p.none, bg = p.bg2 },
    WildMenu = { fg = p.bg0, bg = p.blue },
    Question = { fg = p.yellow },
    SpellBad = { undercurl = true, sp = p.red },
    SpellCap = { fg = p.yellow, undercurl = true, sp = p.yellow },
    SpellLocal = { fg = p.blue, undercurl = true, sp = p.blue },
    SpellRare = { fg = p.purple, undercurl = true, sp = p.purple },
    StatusLine = { fg = p.fg, bg = p.bg2 },
    StatusLineTerm = { fg = p.fg, bg = p.bg2 },
    StatusLineNC = { fg = p.grey, bg = p.bg1 },
    StatusLineTermNC = { fg = p.grey, bg = p.bg1 },
    TabLine = { fg = p.fg, bg = p.bg4 },
    TabLineFill = { fg = p.grey, bg = p.bg1 },
    TabLineSel = { fg = p.bg0, bg = p.bg_red },
    WinSeparator = { fg = p.bg5 },
    VertSplit = { fg = p.bg5 },
    Visual = { bg = p.bg2 },
    VisualNOS = { fg = p.none, bg = p.bg2, underline = true },
    QuickFixLine = { fg = p.blue },
    Debug = { fg = p.yellow },
    debugPC = { fg = p.bg0, bg = p.green },
    debugBreakpoint = { fg = p.bg0, bg = p.red },
    ToolbarButton = { fg = p.bg0, bg = p.bg_blue },
    FocusedSymbol = { bg = p.bg3 },

    Type = { fg = p.blue } + styles.keywords,
    Structure = { fg = p.blue } + styles.keywords,
    StorageClass = { fg = p.blue } + styles.keywords,
    Identifier = { fg = p.orange } + styles.identifiers,
    Constant = { fg = p.orange } + styles.variables,
    PreProc = { fg = p.red },
    PreCondit = { fg = p.red },
    Include = { fg = p.red },
    Keyword = { fg = p.red } + styles.keywords,
    Define = { fg = p.red },
    Typedef = { fg = p.red },
    Exception = { fg = p.red },
    Conditional = { fg = p.red },
    Repeat = { fg = p.red },
    Statement = { fg = p.red },
    Macro = { fg = p.purple },
    Error = { fg = p.red },
    Label = { fg = p.purple },
    Special = { fg = p.purple },
    SpecialChar = { fg = p.purple },
    Boolean = { fg = p.purple },
    String = { fg = p.yellow },
    Character = { fg = p.yellow },
    Number = { fg = p.purple },
    Float = { fg = p.purple },
    Function = { fg = p.green } + styles.functions,
    Operator = { fg = p.red },
    Title = { fg = p.yellow },
    Tag = { fg = p.orange },
    Delimiter = { fg = p.fg },
    Comment = { fg = p.bg4 } + styles.comments,
    SpecialComment = { fg = p.bg4 } + styles.comments,
    Todo = { fg = p.blue } + styles.comments,

    -- whichkey
    WhichKey = { fg = p.red },
    WhichKeyDesc = { fg = p.blue },
    WhichKeyGroup = { fg = p.orange },
    WhichKeySeperator = { fg = p.green },

    -- flash
    FlashBackdrop = { fg = p.bg4 },
    FlashLabel = { fg = p.bg0, bg = p.blue },

    -- gitgutter
    GitGutterAdd = { fg = p.diff_green },
    GitGutterChange = { fg = p.diff_blue },
    GitGutterDelete = { fg = p.diff_red },

    -- diffview
    DiffviewFilePanelTitle = { fg = p.blue, bold = true },
    DiffviewFilePanelCounter = { fg = p.purple, bold = true },
    DiffviewFilePanelFileName = { fg = p.fg },
    DiffviewNormal = { link = "Normal" },
    DiffviewCursorLine = { link = "CursorLine" },
    DiffviewVertSplit = { link = "VertSplit" },
    DiffviewSignColumn = { link = "SignColumn" },
    DiffviewStatusLine = { link = "StatusLine" },
    DiffviewStatusLineNC = { link = "StatusLineNC" },
    DiffviewEndOfBuffer = { link = "EndOfBuffer" },
    DiffviewFilePanelRootPath = { fg = p.grey },
    DiffviewFilePanelPath = { fg = p.grey },
    DiffviewFilePanelInsertions = { fg = p.green },
    DiffviewFilePanelDeletions = { fg = p.red },
    DiffviewStatusAdded = { fg = p.green },
    DiffviewStatusUntracked = { fg = p.blue },
    DiffviewStatusModified = { fg = p.blue },
    DiffviewStatusRenamed = { fg = p.blue },
    DiffviewStatusCopied = { fg = p.blue },
    DiffviewStatusTypeChange = { fg = p.blue },
    DiffviewStatusUnmerged = { fg = p.blue },
    DiffviewStatusUnknown = { fg = p.red },
    DiffviewStatusDeleted = { fg = p.red },
    DiffviewStatusBroken = { fg = p.red },

    -- comments
    commentTSDanger = { fg = p.red } + styles.comments,
    commentTSNote = { fg = p.blue } + styles.comments,
    commentTSWarning = { fg = p.yellow } + styles.comments,

    -- treesitter
    ["@annotation"] = { link = "PreProc", default = true },
    ["@attribute"] = { link = "PreProc", default = true },
    ["@boolean"] = { link = "Boolean", default = true },
    ["@character"] = { link = "Character", default = true },
    ["@character.special"] = { link = "SpecialChar", default = true },
    ["@comment"] = { link = "Comment", default = true },
    ["@conditional"] = { link = "Conditional", default = true },
    ["@constant"] = { link = "Constant", default = true },
    ["@constant.builtin"] = { link = "Special", default = true },
    ["@constant.macro"] = { link = "Define", default = true },
    ["@constructor"] = { link = "Special", default = true },
    ["@debug"] = { link = "Debug", default = true },
    ["@define"] = { link = "Define", default = true },
    ["@defaultLibrary"] = { link = "Special", default = true },
    ["@error"] = { link = "Error", default = true },
    ["@exception"] = { link = "Exception", default = true },
    ["@field"] = { link = "Identifier", default = true },
    ["@float"] = { link = "Float", default = true },
    ["@function"] = { link = "Function", default = true },
    ["@function.builtin"] = { link = "Special", default = true },
    ["@function.call"] = { link = "@function", default = true },
    ["@function.macro"] = { link = "Macro", default = true },
    ["@include"] = { link = "Include", default = true },
    ["@keyword"] = { link = "Keyword", default = true },
    ["@keyword.function"] = { link = "Keyword", default = true },
    ["@keyword.operator"] = { link = "@operator", default = true },
    ["@keyword.return"] = { link = "@keyword", default = true },
    ["@label"] = { link = "Label", default = true },
    ["@method"] = { link = "Function", default = true },
    ["@method.call"] = { link = "@method", default = true },
    ["@namespace"] = { link = "Include", default = true },
    ["@none"] = { bg = "NONE", fg = "NONE", default = true },
    ["@number"] = { link = "Number", default = true },
    ["@operator"] = { link = "Operator", default = true },
    ["@parameter"] = { link = "Identifier", default = true },
    ["@parameter.reference"] = { link = "@parameter", default = true },
    ["@preproc"] = { link = "PreProc", default = true },
    ["@property"] = { link = "Identifier", default = true },
    ["@punctuation.bracket"] = { link = "Delimiter", default = true },
    ["@punctuation.delimiter"] = { link = "Delimiter", default = true },
    ["@punctuation.special"] = { link = "Delimiter", default = true },
    ["@repeat"] = { link = "Repeat", default = true },
    ["@storageclass"] = { link = "StorageClass", default = true },
    ["@string"] = { link = "String", default = true },
    ["@string.escape"] = { link = "SpecialChar", default = true },
    ["@string.regex"] = { link = "String", default = true },
    ["@string.special"] = { link = "SpecialChar", default = true },
    ["@symbol"] = { link = "Identifier", default = true },
    ["@tag"] = { link = "Label", default = true },
    ["@tag.attribute"] = { link = "@property", default = true },
    ["@tag.delimiter"] = { link = "Delimiter", default = true },
    ["@text"] = { link = "@none", default = true },
    ["@text.danger"] = { link = "WarningMsg", default = true },
    ["@text.emphasis"] = { italic = true, default = true },
    ["@text.environment"] = { link = "Macro", default = true },
    ["@text.environment.name"] = { link = "Type", default = true },
    ["@text.literal"] = { link = "String", default = true },
    ["@text.math"] = { link = "Special", default = true },
    ["@text.note"] = { link = "SpecialComment", default = true },
    ["@text.reference"] = { link = "Constant", default = true },
    ["@text.strike"] = { strikethrough = true, default = true },
    ["@text.strong"] = { bold = true, default = true },
    ["@text.title"] = { link = "Title", default = true },
    ["@text.todo"] = { link = "Todo", default = true },
    ["@text.underline"] = { underline = true, default = true },
    ["@text.uri"] = { link = "Underlined", default = true },
    ["@text.warning"] = { link = "Todo", default = true },
    ["@todo"] = { link = "Todo", default = true },
    ["@type"] = { link = "Type", default = true },
    ["@type.builtin"] = { link = "Type", default = true },
    ["@type.definition"] = { link = "Typedef", default = true },
    ["@type.qualifier"] = { link = "Type", default = true },
    ["@variable"] = { fg = p.fg, default = true } + styles.variables,
    ["@variable.builtin"] = { fg = p.purple, default = true },

    -- lsp
    LspCxxHlGroupEnumConstant = { fg = p.orange },
    LspCxxHlGroupMemberVariable = { fg = p.orange },
    LspCxxHlGroupNamespace = { fg = p.blue },
    LspCxxHlSkippedRegion = { fg = p.grey },
    LspCxxHlSkippedRegionBeginEnd = { fg = p.red },
    LspDiagnosticsDefaultError = { fg = p.error },
    LspDiagnosticsDefaultHint = { fg = p.hint },
    LspDiagnosticsDefaultInformation = { fg = p.info },
    LspDiagnosticsDefaultWarning = { fg = p.warn },
    LspDiagnosticsUnderlineError = { undercurl = true, sp = p.error },
    LspDiagnosticsUnderlineHint = { undercurl = true, sp = p.hint },
    LspDiagnosticsUnderlineInformation = { undercurl = true, sp = p.info },
    LspDiagnosticsUnderlineWarning = { undercurl = true, sp = p.warn },
    LspInlayHint = { fg = p.indent_active, bg = 'NONE' },
    DiagnosticUnnecessary = { fg = p.light_gray, bg = 'NONE' },
    DiagnosticError = { fg = p.error, bg = 'NONE' },
    DiagnosticHint = { fg = p.hint, bg = 'NONE' },
    DiagnosticInfo = { fg = p.info, bg = 'NONE' },
    DiagnosticWarn = { fg = p.warn, bg = 'NONE' },
    DiagnosticOther = { fg = p.other, bg = 'NONE' },
    DiagnosticSignError = { link = 'DiagnosticError' },
    DiagnosticSignHint = { link = 'DiagnosticHint' },
    DiagnosticSignInfo = { link = 'DiagnosticInfo' },
    DiagnosticSignWarn = { link = 'DiagnosticWarn' },
    DiagnosticSignOther = { link = 'DiagnosticOther' },
    DiagnosticSignWarning = { link = 'DiagnosticWarn' },
    DiagnosticFloatingError = { link = 'DiagnosticError' },
    DiagnosticFloatingHint = { link = 'DiagnosticHint' },
    DiagnosticFloatingInfo = { link = 'DiagnosticInfo' },
    DiagnosticFloatingWarn = { link = 'DiagnosticWarn' },
    DiagnosticUnderlineWarn = { link = "LspDiagnosticsUnderlineWarning" },
    DiagnosticUnderlineError = { link = "LspDiagnosticsUnderlineError" },
    DiagnosticUnderlineHint = { link = "LspDiagnosticsUnderlineHint" },
    DiagnosticUnderlineInfo = { link = "LspDiagnosticsUnderlineInformation" },
    DiagnosticVirtualTextHint = { fg = p.hint, bg = p.hint_bg },
    DiagnosticVirtualTextInfo = { fg = p.info, bg = p.info_bg },
    DiagnosticVirtualTextWarn = { fg = p.warn, bg = p.warn_bg },
    DiagnosticVirtualTextError = { fg = p.error, bg = p.error_bg },
    LspReferenceRead = { bg = p.bg3 },
    LspReferenceWrite = { bg = p.bg3 },
    LspReferenceText = { bg = p.bg3 },
    LspInfoBorder = { fg = p.bg4 },

    -- lsp semantic tokens
    LspNamespace = { link = "@namespace" },
    LspType = { link = "@type" },
    LspClass = { link = "@type" },
    LspEnum = { link = "@constant" },
    LspInterface = { link = "@constant" },
    LspStruct = { link = "@constant" },
    LspTypeParameter = { link = "@type" },
    LspParameter = { link = "@parameter" },
    LspVariable = { link = "@variable" },
    LspProperty = { link = "@property" },
    LspEnumMember = { link = "@constant" },
    LspEvent = { link = "@constant" },
    LspFunction = { link = "@function" },
    LspMethod = { link = "@method" },
    LspMacro = { link = "@constant.macro" },
    LspKeyword = { link = "@keyword" },
    LspModifier = { link = "TSModifier" },
    LspComment = { link = "@comment" },
    LspString = { link = "@string" },
    LspNumber = { link = "@number" },
    LspRegexp = { link = "@string.regex" },
    LspOperator = { link = "@operator" },
    LspDecorator = { link = "@symbol" },
    LspDeprecated = { link = "@text.strike" },
    ["@lsp.type.namespace"] = { link = "@namespace", default = true },
    ["@lsp.type.type"] = { link = "@type", default = true },
    ["@lsp.type.class"] = { link = "@type", default = true },
    ["@lsp.type.enum"] = { link = "@type", default = true },
    ["@lsp.type.interface"] = { link = "@type", default = true },
    ["@lsp.type.struct"] = { link = "@structure", default = true },
    ["@lsp.type.parameter"] = { link = "@parameter", default = true },
    ["@lsp.type.variable"] = { link = "@variable", default = true },
    ["@lsp.type.property"] = { link = "@property", default = true },
    ["@lsp.type.enumMember"] = { link = "@constant", default = true },
    ["@lsp.type.function"] = { link = "@function", default = true },
    ["@lsp.type.method"] = { link = "@method", default = true },
    ["@lsp.type.macro"] = { link = "@macro", default = true },
    ["@lsp.type.decorator"] = { link = "@function", default = true },

    -- cmp
    CmpItemKindDefault = { fg = p.blue },
    CmpItemAbbrMatch = { fg = p.blue },
    CmpItemAbbrMatchFuzzy = { fg = p.blue },
    CmpItemKindKeyword = { fg = p.fg },
    CmpItemKindVariable = { fg = p.cyan },
    CmpItemKindConstant = { fg = p.cyan },
    CmpItemKindReference = { fg = p.cyan },
    CmpItemKindValue = { fg = p.cyan },
    CmpItemKindFunction = { fg = p.purple },
    CmpItemKindMethod = { fg = p.purple },
    CmpItemKindConstructor = { fg = p.purple },
    CmpItemKindClass = { fg = p.yellow },
    CmpItemKindInterface = { fg = p.yellow },
    CmpItemKindStruct = { fg = p.yellow },
    CmpItemKindEvent = { fg = p.yellow },
    CmpItemKindEnum = { fg = p.yellow },
    CmpItemKindUnit = { fg = p.yellow },
    CmpItemKindModule = { fg = p.yellow },
    CmpItemKindProperty = { fg = p.green },
    CmpItemKindField = { fg = p.green },
    CmpItemKindTypeParameter = { fg = p.green },
    CmpItemKindEnumMember = { fg = p.green },
    CmpItemKindOperator = { fg = p.green },
    CmpItemKindSnippet = { fg = p.red },

    -- coc
    CocErrorSign = { fg = p.red + gamma(0.5) },
    CocHintSign = { fg = p.red + gamma(0.5) },
    CocInfoSign = { fg = p.red + gamma(0.5) },
    CocWarningSign = { fg = p.red + gamma(0.5) },
    FgCocErrorFloatBgCocFloating = { fg = p.red + gamma(0.5), bg = p.bg2 },
    FgCocHintFloatBgCocFloating = { fg = p.purple + gamma(0.5), bg = p.bg2 },
    FgCocInfoFloatBgCocFloating = { fg = p.blue + gamma(0.5), bg = p.bg2 },
    FgCocWarningFloatBgCocFloating = { fg = p.yellow + gamma(0.5), bg = p.bg2 },

    -- gitsigns
    GitSignsAdd = { fg = p.green },
    GitSignsAddLn = { fg = p.green },
    GitSignsAddNr = { fg = p.green },
    GitSignsChange = { fg = p.blue },
    GitSignsChangeLn = { fg = p.blue },
    GitSignsChangeNr = { fg = p.blue },
    GitSignsDelete = { fg = p.red },
    GitSignsDeleteLn = { fg = p.red },
    GitSignsDeleteNr = { fg = p.red },

    -- markdown
    markdownBlockquote = { fg = p.grey },
    markdownBold = { fg = p.none, bold = true },
    markdownBoldDelimiter = { fg = p.grey },
    markdownCodeDelimiter = { fg = p.green },
    markdownH1 = { fg = "#7aa2f7" },
    markdownH2 = { fg = "#e0af68" },
    markdownH3 = { fg = "#9ece6a" },
    markdownH4 = { fg = "#1abc9c" },
    markdownH5 = { fg = "#bb9af7" },
    markdownH6 = { fg = "#9d7cd8" },
    markdownHeadingRule = { fg = p.grey },
    markdownId = { fg = p.yellow },
    markdownIdDeclaration = { fg = p.red },
    markdownItalic = { fg = p.none, italic = true },
    markdownItalicDelimiter = { fg = p.grey, italic = true },
    markdownLinkDelimiter = { fg = p.grey },
    markdownLinkTextDelimiter = { fg = p.grey },
    markdownListMarker = { fg = p.red },
    markdownOrderedListMarker = { fg = p.red },
    markdownRule = { fg = p.purple },
    markdownUrl = { fg = p.blue, underline = true },
    markdownUrlDelimiter = { fg = p.grey },
    markdownUrlTitleDelimiter = { fg = p.green },
    markdownCode = { fg = "#1abc9c" },
    markdownCodeBlock = { fg = "#1abc9c" },
    markdownHeadingDelimiter = {   bold = true,   fg = "#ff9e64"   },
    markdownLinkText = {   fg = "#7aa2f7",   underline = true   },
    mkdCodeDelimiter = {   bg = "#414868",   fg = "#c0caf5"   },
    mkdCodeEnd = {   bold = true,   fg = "#1abc9c"   },
    mkdCodeStart = {   bold = true,   fg = "#1abc9c"   },
    ["@markup"] = { link = "@none" },
    ["@markup.emphasis"] = { italic = true },
    ["@markup.environment"] = { link = "Macro" },
    ["@markup.environment.name"] = { link = "Type" },
    ["@markup.heading"] = { link = "Title" },
    ["@markup.heading.1.markdown"] = { link = "MarkdownH1" },
    ["@markup.heading.2.markdown"] = { link = "MarkdownH3" },
    ["@markup.heading.3.markdown"] = { link = "MarkdownH4" },
    ["@markup.heading.4.markdown"] = { link = "MarkdownH5" },
    ["@markup.heading.5.markdown"] = { link = "MarkdownH6" },
    ["@markup.heading.6.markdown"] = { link = "MarkdownH7" },
    ["@markup.link"] = { fg = "#1abc9c" },
    ["@markup.link.label"] = { link = "SpecialChar" },
    ["@markup.link.label.symbol"] = { link = "Identifier" },
    ["@markup.link.url"] = { link = "Underlined" },
    ["@markup.list"] = { fg = "#89ddff" },
    ["@markup.list.checked"] = { fg = "#73daca" },
    ["@markup.list.markdown"] = { fg = "#ff9e64" },
    ["@markup.list.unchecked"] = { fg = "#7aa2f7" },
    ["@markup.math"] = { link = "Special" },
    ["@markup.raw"] = { link = "String" },
    ["@markup.raw.markdown_inline"] = { bg = "#414868", fg = "#7aa2f7" },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.strong"] = { bold = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.italic"] = { italic = true },

    -- scala
    scalaNameDefinition = { fg = p.fg },
    scalaInterpolationBoundary = { fg = p.purple },
    scalaInterpolation = { fg = p.purple },
    scalaTypeOperator = { fg = p.red },
    scalaOperator = { fg = p.red },
    scalaKeywordModifier = { fg = p.red },

    -- nvim-tree
    NvimTreeExecFile  = { fg = p.orange },
    NvimTreeSpecialFile  = { fg = p.yellow },
    NvimTreeIndentMarker = { fg = p.bg3 },
    NvimTreeImageFile = { fg = p.purple },
    NvimTreeSymlink = { link = "SpecialChar" },
    NvimTreeCopiedHL = { fg = p.warn },
    NvimTreeCutHL = { fg = p.warn },

    -- Noice
    NoiceCmdlineIcon = { link = 'DiagnosticSignInfo' },
    NoiceCmdlinePopupBorder = { link = 'DiagnosticSignInfo' },
    NoiceCmdlinePopupTitle = { link = 'DiagnosticSignHint' },
    NoiceFormatProgressDone = { fg = p.fg, bg = p.select },
    NoiceCmdlinePrompt = { fg = p.fg, bg = "NONE" },

    -- Lua
    ["@lsp.typemod.variable.global.lua"] = { fg = p.cyan, bg = 'NONE' },
    ["@lsp.typemod.variable.defaultLibrary.lua"] = { fg = p.bronze, bg = 'NONE' },
    ["@lsp.mod.global.lua"] = { fg = p.cyan, bg = 'NONE' },
    ["@constant.builtin.lua"] = { fg = p.cyan, bg = 'NONE' },
    ["@field.lua"] = { fg = p.blue_2, bg = 'NONE' },
    ["@constructor.lua"] = { fg = p.fg, bg = 'NONE' },
    ["@variable.lua"] = { fg = p.blue_2, bg = 'NONE' },
    ["@lsp.type.variable.lua"] = { fg = p.blue_2, bg = 'NONE' },
    ["@lsp.type.function.lua"] = { fg = p.purple, bg = 'NONE' },
    ["@lsp.typemod.function.global.lua"] = { link = 'Function' },
    ["@lsp.typemod.variable.declaration.lua"] = { link = 'Variable' },

    -- Typescript
    ["@lsp.type.interface.typescriptreact"] = { fg = p.cyan, bg = 'NONE' },
    ["@lsp.type.namespace.typescriptreact"] = { fg = p.cyan, bg = 'NONE' },
    ["@lsp.typemod.variable.readonly.typescriptreact"] = { fg = p.blue_3, bg = 'NONE' },

    typescriptArrowFuncArg = { fg = p.fg, bg = 'NONE' },
    typescriptCall = { fg = p.fg, bg = 'NONE' },
    typescriptTemplateSB = { fg = p.purple, bg = 'NONE' },
    typescriptBraces = { fg = p.fg, bg = 'NONE' },

    ["@tag.tsx"] = { fg = p.cyan, bg = 'NONE' },
    ["@tag.jsx"] = { fg = p.cyan, bg = 'NONE' },

    -- CSS
    ["@string.special.css"] = { fg = p.dark_yellow, bg = 'NONE' },
    ["@type.definition.css"] = { fg = p.blue_2, bg = 'NONE' },

    -- Rust
    rustEnumVariant = { fg = p.cyan, bg = 'NONE' },
    rustSigil = { fg = p.fg, bg = 'NONE' },
    rustEscape = { link = 'String' },
    ["@lsp.type.formatSpecifier.rust"] = { link = '@punctuation.special' },
    ["@lsp.mod.asynp.rust"] = { fg = p.purple, bg = 'NONE' },
    ["@lsp.typemod.function.declaration.rust"] = { fg = p.yellow, bg = 'NONE' },
    ["@type.qualifier.rust"] = { fg = p.blue_1, bg = 'NONE' },
    ["@lsp.typemod.method.reference.rust"] = { fg = p.yellow, bg = 'NONE' },
    ["@lsp.typemod.keyword.controlFlow.rust"] = { fg = p.purple, bg = 'NONE' },
    ["@lsp.typemod.decorator.library.rust"] = { fg = p.yellow, bg = 'NONE' },
    ["@lsp.typemod.function.asynp.rust"] = { fg = p.yellow, bg = 'NONE' },

    -- toml
    ["@type.toml"] = { fg = p.blue_1, bg = 'NONE' },

    -- html
    ["@markup.heading.html"] = { fg = p.fg, bg = 'NONE' },

    -- zsh
    zshCommands = { fg = p.yellow, bg = 'NONE' },
    zshDeref = { fg = p.fg, bg = 'NONE' },
    zshShortDeref = { fg = p.fg, bg = 'NONE' },
    zshSubst = { fg = p.fg, bg = 'NONE' },
    zshVariableDef = { fg = p.fg, bg = 'NONE' },
    zshSubstDelim = { link = '@punctuation.special' },
    zshKSHFunction = { link = 'Function' },
}

function M.setup()
    local highlights = type(config.custom_highlights) == "function"
            and config.custom_highlights(M.highlights, p)
        or config.custom_highlights
    load_highlights(vim.tbl_extend("force", M.highlights, highlights))
    if config.terminal_colors then
        terminal.setup()
    end
end

return M
