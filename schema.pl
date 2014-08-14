##!/usr/bin/perl
##
## SCHEMA supports the following keys: item, cat, begin_cat, end_cat,
##                                     exit, raw, sep, obgenmenu
##
## Modified by Carl Duff.

=for comment

item: add an item into the menu
{item => ["command", "label", "icon"]}

cat: add a category into the menu
{cat => ["name", "label", "icon"]}

begin_cat: begin of a category
{begin_cat => ["name", "icon"]}

end_cat: end of a category
{end_cat => undef}

sep: menu line separator
{sep => undef} or {sep => "label"}

exit: default "Exit" action
{exit => ["label", "icon"]}

raw: any valid Openbox XML string
{raw => q(xml string)},

obgenmenu: category provided by obmenu-generator
{obgenmenu => "label"}

scripts: executable scripts from a directory
{scripts => ["/my/dir", BOOL, "icon"]}
BOOL - can be either true or false (1 or 0)
0 == open the script in background
1 == open the script in a new terminal

wine_apps: windows applications installed via wine
{wine_apps => ["label", "icon"]}

=cut

# NOTE:
#    * Keys and values are case sensitive. Keep all keys lowercase.
#    * ICON can be a either a direct path to a icon or a valid icon name
#    * By default, category names are case insensitive. (e.g.: X-XFCE == x_xfce)

require '/home/trey/.config/obmenu-generator/config.pl';

our $SCHEMA = [
#             COMMAND                 	LABEL          		ICON
   {sep => m3nu},
   {item => ['gmrun',      		    'Run...','xkill']},
   {item => ['lxterminal',   	 	'lxTerminal','xterm']},
   {item => ['xfce4-terminal',   	 	'XFterm','xfce4-terminal']},
   {item => ['pcmanfm',      		'PCmanFM','pcmanfm']},   
   {item => ['chromium',      		'Chrome','chromium']},
   {item => ['geany',      		    'Geany','geany']},
   {item => ['keepassx',            'KeepassX','keepassx']},
   {item => ['nitrogen',   	 	    'Nitrogen','nitrogen']},
   {sep => undef},

    #          NAME            LABEL                ICON
    {cat => ['utility',     'Apps', 'applications-utilities']},
    {cat => ['development', 'Dev', 'applications-development']},
    {cat => ['education',   'Education',   'applications-science']},
    {cat => ['game',        'Games',       'applications-games']},
    {cat => ['graphics',    'Graphics',    'applications-graphics']},
    {cat => ['audiovideo',  'Multimedia',  'applications-multimedia']},
    {cat => ['network',     'Network',     'applications-internet']},
    {cat => ['office',      'Office',      'applications-office']},
    {cat => ['settings',    'Settings',    'applications-accessories']},

## Custom "Advanced Menu"

   {begin_cat => ['OB Setts',  'gnome-settings']},
   {begin_cat => ['Desktop and Login',  '/usr/share/icons/Faenza/apps/48/dconf-editor.png']},
   {item => ['geany -m ~/.conkyrc','Conky RC','geany']},
   {item => ['geany -m ~/.config/tint2/tint2rc','Tint2 Panel','geany']},
   {item => ['gksu geany /etc/slim.conf','Slim Configuration','geany']},
   {item => ['geany -m ~/.xinitrc','.xinitrc','geany']},
   {item => ['geany -m ~/.xprofile','.xprofile','geany']},
   {end_cat   => undef},
   {begin_cat => ['Edit Menu', '/usr/share/icons/Faenza/apps/48/menu-editor.png']},
		{item => ['geany -m ~/.config/obmenu-generator/schema.pl','Pipe Menu Schema','geany']},
		{item => ['geany -m ~/.config/obmenu-generator/config.pl','Pipe Menu Config','geany']},
		{item => ['obmenu-generator -d','Refresh Icon Set','/usr/share/icons/Faenza/apps/48/application-default-icon.png']},
   {end_cat   => undef},
   {begin_cat => ['Openbox',  'openbox']},
		{item => ['openbox --reconfigure','Reconfigure Openbox','openbox']},
		{item => ['lxappearance','obConf?','obconf']},
		{item => ['geany -m ~/.config/openbox/autostart','Openbox Autostart','geany']},
		{item => ['geany -m ~/.config/openbox/rc.xml','Openbox RC','geany']},
		{item => ['geany -m ~/.config/openbox/menu.xml','Openbox Menu','geany']},
		{item => ['gksu geany /etc/oblogout.conf','Openbox Logout','geany']},
   {end_cat   => undef},
   {begin_cat => ['Pacman / Servers', '/usr/share/icons/Faenza/apps/48/package-manager-icon.png']},
		{item => ['lxterminal -e sudo ~/.config/executables/change-repo.sh','Switch stable, testing and unstable repos','lxterminal']},
		{item => ['gksu geany /etc/pacman.conf','Pacman Config','geany']},
		{item => ['gksu geany /etc/pacman.d/mirrorlist','Pacman Mirrorlist','geany']},
   {end_cat   => undef},
   {end_cat   => undef},

## Back to standard pipe-menu

   {cat => ['system',      'System',      'applications-system']},
   
   {sep => skriptz},
   {item => ['openbox --reconfigure','Rld Openbox->','openbox']},
   #{item => ['killall conky','<-Kill Conky->','xkill']},
   {item => ['/home/trey/skr1ptz/rldConky', 'Rld Conky ->', "xkill"]},
   #{item => ['conky','- Run Conky -','conky']},
   {sep => undef},
   
   ## Use Oblogout script instead of simple exit command
   {item => ['xlock -mode blank', 'Lock Screen', 'lock']},
   {item => ['oblogout',        'Logout...',      'exit']},
   
   {sep => undef},
   {begin_cat => ['Other Apps',  'gnome-settings']},
    {cat => ['qt',          'QT Applications',    'qtlogo']},
    {cat => ['gtk',         'GTK Applications',   'gnome-applications']},
    {cat => ['x_xfce',      'XFCE Applications',  'applications-other']},
    {cat => ['gnome',       'GNOME Applications', 'gnome-applications']},
    {cat => ['consoleonly', 'CLI Applications',   'applications-utilities']},
    {cat => ['Wine apps', 'applications-other']},
   {end_cat   => undef},
    #                  LABEL             ICON
    #{wine_apps => ['Wine apps', 'applications-other']},

]
