# == Schema Information
#
# Table name: made_n_laid_statutory_instruments
#
#  id                    :bigint           not null, primary key
#  laid_on               :date             not null
#  made_on               :date             not null
#  posted_to_bluesky     :boolean          default(FALSE)
#  posted_to_mastodon    :boolean          default(FALSE)
#  procedure             :string(255)      not null
#  procedure_browser_url :string(255)      not null
#  title                 :string(500)      not null
#  uri                   :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class MadeNLaidStatutoryInstrument < ApplicationRecord

  def post_text
    date_format = '%d-%m-%Y'
    post_text = self.title
    post_text += '. '
    post_text += "Made on #{self.made_on.strftime( date_format )}, "
    post_text += "laid on #{self.laid_on.strftime( date_format )}. "
    post_text += "Subject to the #{self.procedure.downcase} procedure. "
    post_text += self.procedure_browser_url
    post_text
  end
end
