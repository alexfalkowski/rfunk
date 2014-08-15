require 'singleton'
require 'ice_nine'
require 'ice_nine/core_ext/object'
require 'concurrent'

require 'rfunk/attribute/immutable'
require 'rfunk/attribute/not_found_error'
require 'rfunk/attribute/pre_condition_error'
require 'rfunk/attribute/post_condition_error'
require 'rfunk/attribute/assertion_error'
require 'rfunk/attribute/immutable_error'
require 'rfunk/attribute/attribute_variable'
require 'rfunk/attribute/error_checking'
require 'rfunk/attribute/attribute_type'
require 'rfunk/attribute/function'
require 'rfunk/attribute/attribute_definition'
require 'rfunk/attribute/attribute_function'
require 'rfunk/attribute/attribute'
require 'rfunk/maybe/option'
require 'rfunk/maybe/none'
require 'rfunk/maybe/some'
require 'rfunk/lazy'
require 'rfunk/either/either'
require 'rfunk/either/failure'
require 'rfunk/either/success'
require 'rfunk/tuple'

include RFunk
