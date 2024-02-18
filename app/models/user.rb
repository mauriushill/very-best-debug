# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  validates(:username, {
    :presence => true,
    :uniqueness => { :case_sensitive => false },
  })

  def my_venue
    my_id = self.id
    matching_venues = Comment.where({ :author_id => my_id })
    return matching_venues
  end

  def the_comments
    my_id = self.username
    matching_comments = Comment.where({ :id => my_id })
    return matching_comments
  end

  def commented_venues

    my_comments = self.comments
    
    array_of_venue_ids = Array.new

    my_comments.each do |a_comment|
      array_of_venue_ids.push(a_comment.venue_id)
    end

    matching_venues = Venue.where({ :id => array_of_venue_ids })

    unique_matching_venues = matching_venues.distinct

    return unique_matching_venues
  end
end
