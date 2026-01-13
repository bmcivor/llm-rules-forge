.PHONY: install uninstall help

INSTALL_DIR := $(HOME)/.local/bin
INSTALL_PATH := $(INSTALL_DIR)/llm-forge

install:
	@mkdir -p "$(INSTALL_DIR)"
	@ln -sf "$(PWD)/generate.sh" "$(INSTALL_PATH)"
	@echo "Installed to $(INSTALL_PATH)"
	@echo "Usage: llm-forge cursor python git ticketing"

uninstall:
	@rm -f "$(INSTALL_PATH)"
	@echo "Removed $(INSTALL_PATH)"

help:
	@echo "Available targets:"
	@echo "  make install    - Install llm-forge to $(INSTALL_PATH)"
	@echo "  make uninstall  - Remove llm-forge from $(INSTALL_PATH)"
	@echo ""
	@echo "After install, use:"
	@echo "  llm-forge cursor python git ticketing"
	@echo "  llm-forge --list"
	@echo "  llm-forge --help"
