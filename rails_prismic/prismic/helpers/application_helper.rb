module ApplicationHelper

	# Returns the full title on a per-page basis.
	def full_title(page_title = '')
	 base_title = SITE_NAME + " • " + SITE_TAGLINE
	 if page_title.empty?
		 base_title
	 else
		 page_title
	 end
	end

	# Returns the seo meta description on a per-page basis.
	def meta_description(page_meta_description = '')
	 if page_meta_description.empty?
		 SITE_META_DESCRIPTION
	 else
		 page_meta_description
	 end
	end

	# Returns the seo keywords on a per-page basis.
	def meta_keywords(page_meta_keywords = '')
	 if page_meta_keywords.empty?
		 SITE_META_KEYWORDS
	 else
		 page_meta_keywords
	 end
	end

	# Returns the featured image for meta data on a per-page basis.
	def meta_image(page_meta_image = '')
	 if page_meta_image.empty?
		 nil
	 else
		 page_meta_image
	 end
	end

end