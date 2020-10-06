# The necessary methods your controller needs to use prismic.io transparently
module PrismicController

	private


	# If something goes wrong, it could be because of an invalid preview token
	def clearcookies
		cookies.delete Prismic::PREVIEW_COOKIE
		redirect_to '/'
	end

	# Setting @ref as the actual ref id being queried, even if it's the master ref.
	# To be used to call the API, for instance: api.form('everything').submit(ref)
	def ref
		@ref ||= preview_ref || experiment_ref || api.master_ref.ref
	end

	def preview_ref
		if request.cookies.has_key?(Prismic::PREVIEW_COOKIE)
			request.cookies[Prismic::PREVIEW_COOKIE]
		else
			nil
		end
	end

	def experiment_ref
		if request.cookies.has_key?(Prismic::EXPERIMENTS_COOKIE)
			api.experiments.ref_from_cookie(request.cookies[Prismic::EXPERIMENTS_COOKIE])
		else
			nil
		end
	end

	##

	# Easier access and initialization of the Prismic::API object.
	def api
		@api ||= PrismicService.init_api
	end

	# Customize the html output of Prismic
	html_serializer = Prismic.html_serializer do |element, html|

		case element

		# Embed
		when Prismic::Fragments::StructuredText::Block::Embed
			%(<div data-oembed="#{element.url}" data-oembed-type="#{element.embed_type.downcase}" data-oembed-provider="#{element.provider.downcase}">#{element.html}</div>)

		# Emphasis
		when Prismic::Fragments::StructuredText::Span::Em
			%(<em>#{html}</em>)

		# Headings
		when Prismic::Fragments::StructuredText::Block::Heading
			%(<h#{element.level}>#{html}</h#{element.level}>)

		# Hyperlink
		when Prismic::Fragments::StructuredText::Span::Hyperlink
			link = element.link
			target = link.target.nil? ? "" : 'target="' + link.target + '" rel="noopener"'
			if link.is_a? Prismic::Fragments::DocumentLink and link.broken
				"<span>#{html}</span>"
			else
				%(<a href="#{link.url(link_resolver)}" #{target}>#{html}</a>)
			end

		# Image
		when Prismic::Fragments::StructuredText::Block::Image
			classes = ['block-img']
			unless element.label.nil?
				classes.push(element.label)
			end
			link = element.link_to
			html = %(<img src="#{element.url}" alt="#{element.alt}" width="#{element.width}" height="#{element.height}" />)
			unless link.nil?
				target = link.target.nil? ? '' : 'target="' + link.target + '" rel="noopener"'
				html = %(<a href="#{link.url(link_resolver)}" #{target}>#{html}</a>)
			end
			%(<p class="#{classes.join(' ')}">#{html}</p>)

		# Label
		when Prismic::Fragments::StructuredText::Span::Label
			%(<span class=\"#{element.label}\">#{html}</span>)

		# List Item
		when Prismic::Fragments::StructuredText::Block::ListItem
			%(<li>#{html}</li>)

		# Paragraph
		when Prismic::Fragments::StructuredText::Block::Paragraph
			%(<p>#{html}</p>)

		# Preformatted
		when Prismic::Fragments::StructuredText::Block::Preformatted
			%(<pre>#{html}</pre>)

		# Strong
		when Prismic::Fragments::StructuredText::Span::Strong
			%(<strong>#{html}</strong>)

		# Default case returns nil
		else
			nil
		end

	end


end