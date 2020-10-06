module PrismicHelper

	# For a given document, describes its URL on your front-office.
	# You really should edit this method, so that it supports all the document types your users might link to.
	#
	# Beware: doc is not a Prismic::Document, but a Prismic::Fragments::DocumentLink,
	# containing only the information you already have without querying more (see DocumentLink documentation)
	def link_resolver()
		@link_resolver ||= Prismic::LinkResolver.new(nil) { |link|
			if link.type == "blog"
				"/blog/" + link.uid
			elsif link.type == "page"
				"/page/" + link.uid
			# Default case for all other types
			else
				document_path(id: link.id, slug: link.slug)
			end
		}
	end

	# Allows to call api directly in the view
	# (to check the bookmarks, for instance, you shouldn't query in the view!)
	def api
		@api
	end

	def endpoint
		PrismicService.config('url')
	end

	# Return the actual used reference
	def ref
		@ref ||= maybe_ref || api.master_ref.ref
	end

	# Return the set reference
	def maybe_ref
		@maybe_ref ||= (params[:ref].blank? ? nil : params[:ref])
	end

end