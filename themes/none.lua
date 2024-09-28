local lexers = vis.lexers

local grey0 = '#333333'

lexers.STYLE_DEFAULT           = ''
lexers.STYLE_NOTHING           = ''
lexers.STYLE_ATTRIBUTE         = ''
lexers.STYLE_CLASS             = ''
lexers.STYLE_COMMENT           = ''
lexers.STYLE_CONSTANT          = ''
lexers.STYLE_DEFINITION        = ''
lexers.STYLE_ERROR             = 'fore:red'
lexers.STYLE_FUNCTION          = ''
lexers.STYLE_FUNCTION_BUILTIN  = lexers.STYLE_FUNCTION
lexers.STYLE_FUNCTION_METHOD   = lexers.STYLE_FUNCTION
lexers.STYLE_HEADING           = ''
lexers.STYLE_KEYWORD           = ''
lexers.STYLE_LABEL             = ''
lexers.STYLE_NUMBER            = ''
lexers.STYLE_OPERATOR          = ''
lexers.STYLE_REGEX             = ''
lexers.STYLE_STRING            = ''
lexers.STYLE_PREPROCESSOR      = ''
lexers.STYLE_TAG               = ''
lexers.STYLE_TYPE              = ''
lexers.STYLE_VARIABLE          = ''
lexers.STYLE_WHITESPACE        = ''
lexers.STYLE_EMBEDDED          = ''
lexers.STYLE_IDENTIFIER        = ''

lexers.STYLE_LINENUMBER        = ''
lexers.STYLE_LINENUMBER_CURSOR = 'bold'
lexers.STYLE_CURSOR            = 'reverse,fore:8'
lexers.STYLE_CURSOR_PRIMARY    = lexers.STYLE_CURSOR
lexers.STYLE_CURSOR_LINE       = 'underlined'
lexers.STYLE_COLOR_COLUMN      = 'back:' .. grey0
lexers.STYLE_SELECTION         = 'reverse'
lexers.STYLE_STATUS            = 'fore:white'
lexers.STYLE_STATUS_FOCUSED    = ''
lexers.STYLE_SEPARATOR         = lexers.STYLE_DEFAULT
lexers.STYLE_INFO              = ''
lexers.STYLE_EOF               = ''

-- diff
lexers.STYLE_ADDITION          = 'fore:green'
lexers.STYLE_CHANGE            = 'fore:yellow'
lexers.STYLE_DELETION          = 'fore:red'

-- markdown
for i = 1,6 do lexers['STYLE_HEADING_H'..i] = 'fore:white' end
lexers.STYLE_BOLD              = 'bold'
lexers.STYLE_ITALIC            = 'italics'
