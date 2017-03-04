class NewsRelease < ActiveRecord::Base

    validates_presence_of :released_on, :title, :body

    def title_with_date
        "#{released_on.strftime("%Y-%m-%d")}: #{title}"
    end

end
