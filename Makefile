.PHONY: all docs doc

docs: 
	markdown-toc-go -i docs/README.md \
        -o ./README.md --glossary docs/glossary.txt -f

doc: docs
