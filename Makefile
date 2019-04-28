build: src/*
	@echo "Building files..."
	@elm make src/Main.elm --output=www/js/app.js
