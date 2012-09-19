# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
  # inflect.plural /^(ox)$/i, '\1en'
  # inflect.singular /^(ox)en/i, '\1'
  # inflect.irregular 'person', 'people'
  # inflect.uncountable %w( fish sheep )

  inflect.plural /([taeiou])([A-Z]|_|\$)/, '\1s\2'
  inflect.plural /([rlnd])([A-Z]|_|$)/, '\1es\2'
  inflect.plural /(is)([A-Z]|_|$)/, '\1es'
  inflect.plural /(i)(z)([A-Z]|_|$)/, '\1ces'
  inflect.singular /([taeiou])s([A-Z]|_|$)/, '\1\2'
  inflect.singular /([rlnd])es([A-Z]|_|$)/, '\1\2'
  inflect.singular /ises([A-Z]|_|$)/, '\1is'
  inflect.singular /ices([A-Z]|_|$)/, '\1iz'
  inflect.plural /([aeiou])([A-Z]|_|$)/, '\1s\2'
  inflect.irregular 'user', 'users'
  inflect.irregular 'tipo_novedad', 'tipo_novedades'
  inflect.irregular 'descarga_bauxita', 'descarga_bauxita'
  inflect.irregular 'arribo_bauxita', 'arribo_bauxita'
  inflect.irregular 'tipos_equipo', 'tipos_equipos'

  # inflect.plural /([aeiou])([A-Z]|_|$)/, '\1s\2'
  # inflect.plural /([rlnd])([A-Z]|_|$)/, '\1es\2'
  # inflect.plural /([aeiou])([A-Z]|_|$)([a-z]+)([rlnd])($)/, '\1s\2\3\4es\5'
  # inflect.plural /([rlnd])([A-Z]|_|$)([a-z]+)([aeiou])($)/, '\1es\2\3\4s\5'
  # inflect.singular /([aeiou])s([A-Z]|_|$)/, '\1\2'
  # inflect.singular /([rlnd])es([A-Z]|_|$)/, '\1\2'
  # inflect.singular /([aeiou])s([A-Z]|_)([a-z]+)([rlnd])es($)/, '\1\2\3\4\5'
  # inflect.singular /([rlnd])es([A-Z]|_)([a-z]+)([aeiou])s($)/, '\1\2\3\4\5'
end
#
# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.acronym 'RESTful'
# end
