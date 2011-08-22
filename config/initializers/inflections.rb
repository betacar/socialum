# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format 
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

ActiveSupport::Inflector.inflections do |inflect|
    #inflect.plural /^(ox)$/i, '\1en'
    #inflect.singular /^(ox)en/i, '\1'
    #inflect.irregular 'person', 'people'
    #inflect.uncountable %w( fish sheep )
    inflect.plural /([taeiou])([A-Z]|_|\$)/, '\1s\2'
    inflect.plural /([rlnd])([A-Z]|_|$)/, '\1es\2'
    inflect.plural /(is)([A-Z]|_|$)/, '\1es'
    inflect.plural /(i)(z)([A-Z]|_|$)/, '\1ces'
    inflect.singular /([taeiou])s([A-Z]|_|$)/, '\1\2'
    inflect.singular /([rlnd])es([A-Z]|_|$)/, '\1\2'
    inflect.singular /ises([A-Z]|_|$)/, '\1is'
    inflect.singular /ices([A-Z]|_|$)/, '\1iz'
    inflect.plural /([aeiou])([A-Z]|_|$)/, '\1s\2'
end