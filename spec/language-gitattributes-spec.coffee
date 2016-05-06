describe 'Git attributes grammars', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage 'language-gitattributes'

    runs ->
      grammar = atom.grammars.grammarForScopeName 'source.git-attributes'

  # convenience function during development
  debug = (tokens) ->
    console.log JSON.stringify(tokens, null, ' ')

  describe 'should parse when', ->

    it 'contains simple attribute', ->
      {tokens} = grammar.tokenizeLine 'file.txt foo'
      expect(tokens).toHaveLength 2
      expect(tokens[0]).toEqualJson value: 'file.txt', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'constant.pattern.git-attributes']
      expect(tokens[1]).toEqualJson value: ' foo', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes']

    it 'contains attribute with key and value', ->
      {tokens} = grammar.tokenizeLine 'file.txt foo=bar'
      expect(tokens).toHaveLength 5
      expect(tokens[0]).toEqualJson value: 'file.txt', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'constant.pattern.git-attributes']
      expect(tokens[1]).toEqualJson value: ' ', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes']
      expect(tokens[2]).toEqualJson value: 'foo', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes', 'punctuation.definition.seperator.attribute.git-attributes', 'string.key.attribute.git-attributes']
      expect(tokens[3]).toEqualJson value: '=', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes', 'punctuation.definition.seperator.attribute.git-attributes', 'punctuation.definition.seperator.attribute.git-attributes']
      expect(tokens[4]).toEqualJson value: 'bar', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes', 'punctuation.definition.seperator.attribute.git-attributes', 'markup.italic.value.attribute.git-attributes']

    it 'contains negate attribute', ->
      {tokens} = grammar.tokenizeLine 'file.txt -foo'
      expect(tokens).toHaveLength 3
      expect(tokens[0]).toEqualJson value: 'file.txt', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'constant.pattern.git-attributes']
      expect(tokens[1]).toEqualJson value: ' ', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes']
      expect(tokens[2]).toEqualJson value: '-foo', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes', 'markup.deleted.negate.attribute.git-attributes']

    it 'contains negate attribute with key and value', ->
      {tokens} = grammar.tokenizeLine 'file.txt -foo=bar'
      expect(tokens).toHaveLength 5
      expect(tokens[0]).toEqualJson value: 'file.txt', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'constant.pattern.git-attributes']
      expect(tokens[1]).toEqualJson value: ' ', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes']
      expect(tokens[2]).toEqualJson value: '-foo', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes', 'markup.deleted.negate.attribute.git-attributes']
      expect(tokens[3]).toEqualJson value: '=', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes', 'markup.deleted.negate.attribute.git-attributes', 'punctuation.definition.seperator..attribute.git-attributes']
      expect(tokens[4]).toEqualJson value: 'bar', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes', 'markup.deleted.negate.attribute.git-attributes', 'markup.italic.att']

    it 'contains multiple simple attributes', ->
      {tokens} = grammar.tokenizeLine 'file.txt foo bar fii bir'
      expect(tokens).toHaveLength 2
      expect(tokens[0]).toEqualJson value: 'file.txt', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'constant.pattern.git-attributes']
      expect(tokens[1]).toEqualJson value: ' foo bar fii bir', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes']

    it 'contains multiple attributes with negate', ->
      {tokens} = grammar.tokenizeLine 'file.txt foo -bar fii bir'
      expect(tokens).toHaveLength 4
      expect(tokens[0]).toEqualJson value: 'file.txt', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'constant.pattern.git-attributes']
      expect(tokens[1]).toEqualJson value: ' foo ', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes']
      expect(tokens[2]).toEqualJson value: '-bar', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes', 'markup.deleted.negate.attribute.git-attributes']
      expect(tokens[3]).toEqualJson value: ' fii bir', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes']


    it 'contains attribute with key and complexe value', ->
      {tokens} = grammar.tokenizeLine '*.css     text eol=lf whitespace=blank-at-eol,-blank-at-eof,-space-before-tab,tab-in-indent,tabwidth=2'
      expect(tokens).toHaveLength 10
      expect(tokens[0]).toEqualJson value: '*', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'constant.pattern.git-attributes', 'constant.other.symbol.asterisk.git-attributes']
      expect(tokens[1]).toEqualJson value: '.css', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'constant.pattern.git-attributes']
      expect(tokens[2]).toEqualJson value: '     text ', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes']
      expect(tokens[3]).toEqualJson value: 'eol', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes', 'punctuation.definition.seperator.attribute.git-attributes', 'string.key.attribute.git-attributes']
      expect(tokens[4]).toEqualJson value: '=', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes', 'punctuation.definition.seperator.attribute.git-attributes', 'punctuation.definition.seperator.attribute.git-attributes']
      expect(tokens[5]).toEqualJson value: 'lf', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes', 'punctuation.definition.seperator.attribute.git-attributes', 'markup.italic.value.attribute.git-attributes']
      expect(tokens[6]).toEqualJson value: ' ', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes']
      expect(tokens[7]).toEqualJson value: 'whitespace', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes', 'punctuation.definition.seperator.attribute.git-attributes', 'string.key.attribute.git-attributes']
      expect(tokens[8]).toEqualJson value: '=', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes', 'punctuation.definition.seperator.attribute.git-attributes', 'punctuation.definition.seperator.attribute.git-attributes']
      expect(tokens[9]).toEqualJson value: 'blank-at-eol,-blank-at-eof,-space-before-tab,tab-in-indent,tabwidth=2', scopes: ['source.git-attributes', 'simple.line.git-attributes', 'string.attributes.git-attributes', 'punctuation.definition.seperator.attribute.git-attributes', 'markup.italic.value.attribute.git-attributes']
