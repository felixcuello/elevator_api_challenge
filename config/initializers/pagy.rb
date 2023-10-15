# frozen_string_literal: true

require "pagy/extras/metadata"

Pagy::DEFAULT[:metadata] = %i[
  count page pages prev next last items
]
