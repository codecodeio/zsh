
eval "$(/opt/homebrew/bin/brew shellenv)"

# PNPM
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
	*":$PNPM_HOME:"*) ;;
	*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Local user binaries
case ":$PATH:" in
	*":$HOME/.local/bin:"*) ;;
	*) export PATH="$HOME/.local/bin:$PATH" ;;
esac
