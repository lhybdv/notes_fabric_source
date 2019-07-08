module Jekyll
    class DataSorter < Jekyll::Generator
      safe true
      priority :lowest
  
      def initialize(config)
      end
  
      def generate(site)
        config = site.config
  
        # if !config['jekyll_category_sort']
        #   return
        # end

        if !config['categories']
          return
        end
        ans = []
        categories = config['categories']
        # for i in 0..categories.size
        categories.each do |cgConfig|
          site.categories.each do |cg|
            if cg[0] == cgConfig['name']
              cg.push(cgConfig['showName'])
              ans.push(cg)
            end
          end
        end
        config["categories_sorted"] = ans
      end
  
      # Filter content collection by the "include_tags" attribute on the config
      #   +content_collection+ an array of hashes
      #   +tags+ an array of tags to filter by 
      #
      # Returns a filtered collection by tag
      def filter_by_tag(content_collection, tags)
        filtered = []
        content_collection.each { |item|
          tags.each do |tag|
            if item["tags"].include?(tag) || item["tags"].include?(tag.capitalize)
              filtered.push(item)
              next
            end
          end
        }
        filtered
      end
    end
end