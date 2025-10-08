# == Schema Information
#
# Table name: treaties
#
#  id                     :bigint           not null, primary key
#  laid_on                :date             not null
#  lead_organisation_name :string(255)      not null
#  posted_to_bluesky      :boolean          default(FALSE)
#  posted_to_mastodon     :boolean          default(FALSE)
#  procedure_browser_url  :string(255)      not null
#  series_citation        :string(255)      not null
#  title                  :string           not null
#  uri                    :string(255)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class Treaty < ApplicationRecord
end
