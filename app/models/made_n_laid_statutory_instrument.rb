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
  
  def bluesky_post_text
    date_format = '%d-%m-%Y'
    
    # Bluesky allows for posts with a character length of 300.
    # The rest of post - made date, laid date, procedure and link - take up a maximum of 151 characters.
    # If the title is truncated, we want to add an ellipsis and a space, taking another four characters.
    # This leaves us with 145 characters, so we truncate - if necessary - to that.
    post_text = self.truncated_title( 145 )
    
    post_text += "Made on #{self.made_on.strftime( date_format )}, "
    post_text += "laid on #{self.laid_on.strftime( date_format )}. "
    post_text += "Subject to the #{self.procedure.downcase} procedure. "
    post_text += self.procedure_browser_url
    post_text
  end
  
  def mastodon_post_text
    date_format = '%d-%m-%Y'
    
    # Mastodon allows for posts with a character length of 500.
    # The rest of post - made date, laid date, procedure and link - take up a maximum of 151 characters.
    # If the title is truncated, we want to add an ellipsis and a space, taking another four characters.
    # This leaves us with 345 characters, so we truncate - if necessary - to that.
    post_text = self.truncated_title( 345 )
    
    post_text += "Made on #{self.made_on.strftime( date_format )}, "
    post_text += "laid on #{self.laid_on.strftime( date_format )}. "
    post_text += "Subject to the #{self.procedure.downcase} procedure. "
    post_text += self.procedure_browser_url
    post_text
  end
  
  # A method to truncate the instrument title.
  def truncated_title( max_length )

    # We create a truncated title string for length comparison.
    truncated_title_for_length_comparison = ''
  
    # We create the truncated title string.
    truncated_title = ''
  
    # We split the title into an array of words.
    words = self.title.split( ' ' )
  
    # For each word ...
    words.each_with_index do |word, index|
    
      # If the truncated title plus the word plus a space is less than the maximum length ...
      if ( truncated_title_for_length_comparison += word + ' ' ).size < max_length
    
        # ... we add the word to the truncated title and append a space.
        truncated_title += word + ' '
      end
    end
  
    # We strip any trailing space from the truncated title.
    truncated_title = truncated_title.strip
  
    # If the title has not been truncated ...
    if truncated_title == self.title
  
      # ... we add a full stop and a space to the truncated title.
      truncated_title += '. '
    
    # Otherwise, if the title has been truncated ...
    else
  
      # ... we add an ellipsis and a space to the truncated title.
      truncated_title += '... '
    end
  
    # We return the truncated title.
    truncated_title
  end
end
