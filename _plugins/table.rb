require "csv"

class RenderTable < Liquid::Block

  def initialize(tag_name, markup, tokens)
     super

     @markup = markup
  end

  def render(context)
    table = CSV.read("data/#{context[@markup.strip]}", :headers => true)
                .map { |r| r.to_hash }

    rss_reg = { "rows" => table }
     context.stack do
       context['table'] = rss_reg
       render_all(@nodelist, context)
     end
  end
end

Liquid::Template.register_tag('csvtable', RenderTable)
