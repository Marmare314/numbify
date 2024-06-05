root := justfile_directory()

export TYPST_ROOT := root

doc cmd='compile':
    typst {{ cmd }} docs/docs.typ doc/docs.pdf

examples:
    typst compile tests/examples/figures/test.typ assets/example-figures.png

test filter='':
    typst-test run {{ filter }}

update filter='':
    typst-test update {{ filter }}

release: test doc examples
