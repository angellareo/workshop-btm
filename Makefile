.PHONY: deploy clean render

# Deploy the site to gh-pages
deploy:
	quarto render
	quarto publish gh-pages --no-prompt

# Clean rendered files
clean:
	quarto clean

# Just render the site locally
render:
	quarto render
