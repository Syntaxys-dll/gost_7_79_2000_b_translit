## GOST 7.79-2000 type b transliteration ##

Transliterate between cyrillic -> latin and vice versa with GOST 7.79-2000 type b rules.

### Install ###

```gem install gost_translit```

### Usage ###

Autodetection:

```
GostTranslit.convert('Вы не пройдете пока не получите бумаги')
#=> "Vy` ne projdete poka ne poluchite bumagi!"

GostTranslit.convert('Vy` ne projdete poka ne poluchite bumagi!')
#=> "Вы не пройдете пока не получите бумаги!"
```

Target language transliteration:

```
GostTranslit.to_latin('Под этим солнцем и небом мы тепло приветствуем тебя.')
#=> "Pod e`tim solncem i nebom my` teplo privetstvuem tebya."

GostTranslit.to_cyrillic('Pod e`tim solncem i nebom my` teplo privetstvuem tebya.')
#=> "Под этим солнцем и небом мы тепло приветствуем тебя."
```

### Features ###

No uppercase words camel case hell in this implementation, e.g.:

```
GostTranslit.to_latin('CЕРГЕЙ АНАТОЛЬЕВИЧ НЕЛОТОВ')
#=> "CERGEJ ANATOL`EVICH NELOTOV"

GostTranslit.to_latin('Сергей Анатольевич Нелотов проживает на ВДНХ')
#=> "Sergej Anatol`evich Nelotov prozhivaet na VDNX"
```
