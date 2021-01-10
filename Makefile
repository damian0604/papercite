###############################################################################
# Make file for the papercite WordPress Plugin
#
# Author: Alexander Willner
###############################################################################

# Config
SHELL=/bin/bash
GITHUB=alexanderwillner/papercite
SRC=.
TESTS=tests
DOC=docs
LINTER=phpcs
UNITTESTER=phpunit

help: ## Print help for each target
	$(info Papercite Makefile)
	$(info ==================)
	$(info )
	$(info Available commands:)
	$(info )
	@grep '^[[:alnum:]_-]*:.* ##' $(MAKEFILE_LIST) \
        | sort | awk 'BEGIN {FS=":.* ## "}; {printf "%-25s %s\n", $$1, $$2};'

todo: ## Show open issues
	@echo "Finding todos..."
	@find "$(SRC)" -iname "*.php" -exec grep -HEIins "todo|fixme" {} \;

lint: ## Check for code lint
	@echo "Running '$(LINTER)'..."
	@command -v $(LINTER)>/dev/null 2>&1 || { echo "Install '$(LINTER)' first and put it into the path" >&2 ; exit 1; }
	@composer global require wp-coding-standards/wpcs
	@phpcs --config-set installed_paths $$HOME/.composer/vendor/wp-coding-standards/wpcs
	@$(LINTER)

test: ## Run unit tests
	@echo "Running '$(UNITTESTER)'..."
	@command -v $(UNITTESTER)>/dev/null 2>&1 || { echo "Install '$(UNITTESTER)' first and put it into the path" >&2 ; exit 1; }
	@$(UNITTESTER)

feedback: ## Provide feedback
	@open https://github.com/$(GITHUB)/issues
 