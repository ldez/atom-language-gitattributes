describe 'Git attributes grammars', ->
  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage 'language-gitattributes'

  it 'load the "gitattributes" config grammar', ->
    grammar = atom.grammars.grammarForScopeName 'source.git-attributes'
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe 'source.git-attributes'
