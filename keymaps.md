### Grammar | Syntax {{{		###

whitespace	= Any( ' ' '\t' '\v' )		# Ignored
newline		= Any( '\n' '\r' )

RawStr		= '..'		# Exactly what you write
ExpandStr	= ".."		# Expands escape symbols
TemplateStr	= `..`		# Allows to include variables with '$var' and '$(var)'

comments:
	'#' .. Newline
	'#'{2..} .. '#'{2..}

List		: '(' expr* ')'
Optional	: expr '?'
ZeroOrMore	: expr '*'
OneOrMore	: expr '+'
Union		:
	|> 'Any' List
	|> expr ('|' expr)*
	|> ('|>' expr)*

Match		: expr ('|>' Then)*

TypeDecl	: NewType ':' Type
TypeBound   : 'where' expr ':' Type
Assignment	: newVar '=' expr

Then | Do	: cond | expr '=>' Action
Action		: expr | stmt

Tag			: [expr]

### }}}							###


### Variables {{{				###

super	= 'Mod4'
meta	= 'Mod1'
ctrl	= 'Control'
shift	= 'Shift'
space	= 'Space'
ret		= 'Return'
bs		= 'BackSpace'

up		= Any( 'e' 'k' 'arrow-up'		)
down	= Any( 'n' 'j' 'arrow-down'		)
left	= Any( 'h'     'arrow-left'		)
right	= Any( 'i' 'l' 'arrow-right'	)

Number	: Any( 0 1 2 3 4 5 6 7 8 9 )
Alpha	: Any( a b c d .. x y z A B .. X Y Z )

### }}}							###


meta  + space			=> ApplicationLauncher	[Quick]
super + space			=> ApplicationLauncher	[Dropdown]

meta  + ret				=> Terminal				[Default, Transparent]
meta  + t				=> Terminal				[Dropdown]
super + ret				=> Terminal				[Fullscreen, Working]


# Launch applications
# Super +
#			Alpha

super + b				=> Browser				[Default]
super + n				=> DefaultEditor		[Neovide]


# Window | Workspace movement

occupied-keys:
	|> super		+ down|left|right
	|> super Shift? + Number
	|> meta  Shift? + up|down|left|right

super + <n>				=> SwitchToWorkspace	 n [where n: Number]
super + shift + <n>		=> MoveWindowToWorkspace n [where n: Number]
super + left			=> SwitchToWorkspace	 [Previous]
super + right			=> SwitchToWorkspace	 [Next]
super + left			=> MoveWindowToWorkspace [Previous]
super + right			=> MoveWindowToWorkspace [Next]

meta + direction			=> ChangeFocus direction [where direction: up|down|left|right]
meta + shift + direction	=> MoveWindow  direction [where direction: up|down|left|right]



