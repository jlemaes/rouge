# -*- coding: utf-8 -*- #
# frozen_string_literal: true

describe Rouge::Lexers::Javascript do
  let(:subject) { Rouge::Lexers::Javascript.new }

  describe 'lexing' do
    include Support::Lexing

    it %(doesn't let a bad regex mess up the whole lex) do
      assert_has_token 'Error',          "var a = /foo;\n1"
      assert_has_token 'Literal.Number', "var a = /foo;\n1"
    end
  end

  describe 'guessing' do
    include Support::Guessing

    it 'guesses by filename' do
      assert_guess :filename => 'foo.js'
      assert_guess Rouge::Lexers::JSON, :filename => 'foo.json'
      assert_guess Rouge::Lexers::JSON, :filename => 'Pipfile.lock'
    end

    it 'guesses by mimetype' do
      assert_guess :mimetype => 'text/javascript'
      assert_guess Rouge::Lexers::JSON, :mimetype => 'application/json'
      assert_guess Rouge::Lexers::JSON, :mimetype => 'application/vnd.api+json'
      assert_guess Rouge::Lexers::JSON, :mimetype => 'application/hal+json'
      assert_guess Rouge::Lexers::JSON, :mimetype => 'application/problem+json'
      assert_guess Rouge::Lexers::JSON, :mimetype => 'application/schema+json'
    end

    it 'guesses by source' do
      assert_guess :source => '#!/usr/bin/env node'
      assert_guess :source => '#!/usr/local/bin/jsc'
    end
  end
end
