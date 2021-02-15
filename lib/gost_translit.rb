# frozen_string_literal: true

module GostTranslit
  UPPER_REGEXP = /[[:upper:]]/
  LOWER_REGEXP = /[[:lower:]]/

  RU_MAPPING = {
    'а': 'a',
    'б': 'b',
    'в': 'v',
    'г': 'g',
    'д': 'd',
    'е': 'e',
    'ё': 'yo',
    'ж': 'zh',
    'з': 'z',
    'и': 'i',
    'й': 'j',
    'к': 'k',
    'л': 'l',
    'м': 'm',
    'н': 'n',
    'о': 'o',
    'п': 'p',
    'р': 'r',
    'с': 's',
    'т': 't',
    'у': 'u',
    'ф': 'f',
    'х': 'x',
    'ц': 'cz',
    'ч': 'ch',
    'ш': 'sh',
    'щ': 'shh',
    'ъ': '``',
    'ы': 'y`',
    'ь': '`',
    'э': 'e`',
    'ю': 'yu',
    'я': 'ya'
  }

  LATIN_REPLACING_MAPPING = {
    'shh' => 'щ',
    'sh'  => 'ш',
    'yu'  => 'ю',
    'ya'  => 'я',
    '``'  => 'ъ',
    'y`'  => 'ы',
    'e`'  => 'э',
    'ch'  => 'ч',
    'cz'  => 'ц',
    'zh'  => 'ж',
    'yo'  => 'ё'
  }

  LATIN_MAPPING = Hash[
    GostTranslit::RU_MAPPING.invert.collect { |k, v| [ k.to_s, v.to_s ] }
  ].merge!('c' => 'ц')

  class << self
    def to_latin(string)
      words = string.split(' ')

      words.map! do |word|
        translit_word = word.downcase
                            .split('')
                            .map { |l| RU_MAPPING[l.to_sym] || l}
                            .join

        translit_word.gsub!(/(cz)(?=[i|e|j|y])/, 'c')
        apply_capitalize_rules(word, translit_word)
      end.join(' ')
    end

    def to_cyrillic(string)
      words = string.split(' ')

      words.map! do |word|
        translit_word = word.downcase
        LATIN_REPLACING_MAPPING.each { |k,v| translit_word.gsub!(k, v) }

        translit_word = translit_word.split('')
                                     .map! { |l| LATIN_MAPPING[l] || l }
                                     .join

        apply_capitalize_rules(word, translit_word)
      end.join(' ')
    end

    def convert(string)
      language(string) == :rus ? to_latin(string) : to_cyrillic(string)
    end

    private

    def language(string)
      string.scan(/\w+/).empty? ? :rus : :eng
    end

    def apply_capitalize_rules(word, translit_word)
      case
      when UPPER_REGEXP.match?(word[0]) && word.match?(LOWER_REGEXP)
        translit_word.capitalize
      when !word.match?(LOWER_REGEXP)
        translit_word.upcase
      else
        translit_word
      end
    end
  end
end
