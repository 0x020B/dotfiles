# If you come from bash you might have to change your $PATH.
export PATH=$PATH:$HOME/.local/bin

umask 077

# Path to your oh-my-zsh installation.
ZSH=/usr/share/zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="random"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
ZSH_THEME_RANDOM_CANDIDATES=(
	"af-magic"		"afowler"	"amuse"		"apple"	
	"arrow"			"avit"		"awesomepanda"	"cloud"
	"crunch"		"cypher"	"daveverwer"	"dogenpunk"
	"eastwood"		"edvardm"	"evan"		"flazz"
	"frontcube"		"fwalch"	"gallifrey"	"gallois"
	"garyblessington"	"gozilla"	"imajes"	"jaischeema"
	"jbergantine"		"jnrowe"	"jonathan"	"kennethreitz"
	"kolo"			"lambda"	"macovsky"	"mgutz"
	"mikeh"			"miloshadzic"	"minimal"	"mrtazz"
	"muse"			"nanotech"	"nebirhos"	"nicoulaj"
	"norm"			"peepcode"	"refined"	"robbyrussell"
	"sammy"			"simple"	"skaro"		"sonicradish"
	"sorin"			"sunaku"	"sunrise"
	"superjarin"		"terminalparty"	"theunraveler"	"wedisagree"
	"wezm"			"zhann"
)

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$ZSH/custom

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions zsh-syntax-highlighting)


# User configuration
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_CONFIG=$HOME/.config/tmux/tmux.conf

# export MANPATH="/usr/local/man:$MANPATH"
export XCURSOR_PATH=${XCURSOR_PATH}:~/.local/share/icons
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CURRENT_DESKTOP="sway"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export mailpath=(~/mail/index/new'?您有新的邮件')
export INPUT_METHOD DEFAULT=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export GLFW_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
export QT_QPA_PLATFORMTHEME=qt5ct
export SDL_VIDEODRIVER=x11
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
	mkdir $ZSH_CACHE_DIR
fi
function command_not_found_handler {
	local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
	printf 'zsh: %s 命令不存在\n' "$1"
	local entries=(${(f)"$(paru -F --machinereadable -- "$1" 2>/dev/null)"})
	if (( ${#entries[@]} )); then
		printf "${bright}$1${reset} 可以在下列软件包中找到：\n"
		local pkg
		for entry in "${entries[@]}"
		do
			# (repo package version file)
			local fields=(${(0)entry})
			if [[ "$pkg" != "${fields[2]}" ]]; then
				printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
			fi
			printf '    /%s\n' "${fields[4]}"
			pkg="${fields[2]}"
		done
	fi
	return 127
}
source $ZSH/oh-my-zsh.sh
alias ls="ls --color"
alias la="ls -a"
alias cp="rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1"
alias mv="rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files"
alias cat="bat --style=plain"
alias diff="colordiff"
alias telegram="flatpak run org.telegram.desktop --socket=fallback-x11 2>/dev/null&"
function pass(){PASSWORD_STORE_GPG_OPTS="--pinentry-mode loopback  --passphrase 秘密" /usr/bin/pass $@}
