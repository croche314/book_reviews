class ReviewsController < ApplicationController
	def index
		#@recents = recents
		#@books = reviews .exclude recents
		@all_reviews = Review.order('created_at DESC')
		total = @all_reviews.length-1
		@recents = []
		@recents << @all_reviews[0..2]
		@books = []
		@books << @all_reviews[3..total]
	end
end
