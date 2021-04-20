# frozen_string_literal: true

require 'rspec'
require 'gost_translit'

RSpec.describe GostTranslit do
  subject { GostTranslit }

  let(:latin_str) { 'Xot` tyazhelo podchas v nej bremya' }
  let(:cyrillic_str) { 'Хоть тяжело подчас в ней бремя' }

  let(:cyrillic_text) do
    text = <<~HEREDOC
      Хоть тяжело подчас в ней бремя,
      Телега на ходу легка;
      Ямщик лихой, седое время,
      Везет, не слезет с облучка.

      С утра садимся мы в телегу;
      Мы рады голову сломать
      И, презирая лень и негу,
      Кричим: пошел! Ебёна мать!

      Но в полдень нет уж той отваги;
      Порастрясло нас; нам страшней
      И косогоры и овраги;
      Кричим: полегче, дуралей!

      Катит по-прежнему телега;
      Под вечер мы привыкли к ней
      И, дремля, едем до ночлега —
      А время гонит лошадей.
    HEREDOC

    text.gsub(/\s+/, ' ').strip
  end

  let(:latin_text) do
    text = <<~HEREDOC
      Xot` tyazhelo podchas v nej bremya,
      Telega na xodu legka;
      Yamshhik lixoj, sedoe vremya,
      Vezet, ne slezet s obluchka.

      S utra sadimsya my` v telegu;
      My` rady` golovu slomat`
      I, preziraya len` i negu,
      Krichim: poshel! Ebyona mat`!

      No v polden` net uzh toj otvagi;
      Porastryaslo nas; nam strashnej
      I kosogory` i ovragi;
      Krichim: polegche, duralej!

      Katit po-prezhnemu telega;
      Pod vecher my` privy`kli k nej
      I, dremlya, edem do nochlega —
      A vremya gonit loshadej.
    HEREDOC

    text.gsub(/\s+/, ' ').strip
  end

  describe '.to_cyrillic' do
    it 'translit text to cyrillic' do
      expect(subject.to_cyrillic(latin_str)).to eq(cyrillic_str)
    end

    context '"c" letter' do
      it 'changed to "ц" when next letter "e"' do
        expect(subject.to_cyrillic('celoe')).to eq('целое')
      end

      it 'changed to "ц" when next letter "i"' do
        expect(subject.to_cyrillic('citadel`')).to eq('цитадель')
      end

      it 'changed to "ц" when next letter "y"' do
        expect(subject.to_cyrillic('cyurix')).to eq('цюрих')
      end

      it 'changed to "ц" when next letter "j"' do
        expect(subject.to_cyrillic('cj')).to eq('цй')
      end

      it 'changed to "ц" from "cz"' do
        expect(subject.to_cyrillic('czaplya')).to eq('цапля')
      end
    end
  end

  describe '.to_latin' do
    it 'translit text to latin' do
      expect(subject.to_latin(cyrillic_str)).to eq(latin_str)
    end

    context '"ц" letter' do
      it 'changed to "c" when next letter "e"' do
        expect(subject.to_latin('целое')).to eq('celoe')
      end

      it 'changed to "c" when next letter "i"' do
        expect(subject.to_latin('цитадель')).to eq('citadel`')
      end

      it 'changed to "c" when next letter "y"' do
        expect(subject.to_latin('цюрих')).to eq('cyurix')
      end

      it 'changed to "c" when next letter "j"' do
        expect(subject.to_latin('цй')).to eq('cj')
      end

      it 'changed to "cz"' do
        expect(subject.to_latin('цапля')).to eq('czaplya')
      end
    end
  end

  describe '.translit' do
    it 'translit latin text to cyrillic' do
      expect(subject.translit(latin_text)).to eq(cyrillic_text)
    end

    it 'translit cyrillic text to latin' do
      expect(subject.translit(cyrillic_text)).to eq(latin_text)
    end
  end
end
