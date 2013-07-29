module Eve
  class API
    module Services
      module Eve
        def alliance_list;     request(:eve, :alliance_list);     end
        def certificate_tree;  request(:eve, :certificate_tree, :column_mapping => { 'level' => 'skillLevel' });  end
        def conquerable_station_list; request(:eve, :conquerable_station_list); end
        def error_list; request(:eve, :error_list); end
        def fac_war_stats; request(:eve, :fac_war_stats); end
        def fac_war_top_stats; request(:eve, :fac_war_top_stats); end
        def skill_tree; request(:eve, :skill_tree); end

        # Returns a list of transaction types used in the Journal Entries
        # Response Example:
        #   result = api.eve.ref_types
        #   result.ref_types                    #=> (Rowset)
        #   result.ref_types[0].ref_type_id     #=> 0
        #   result.ref_types[0].ref_type_name   #=> "Undefined"
        #   result.ref_types[1].ref_type_id     #=> 1
        #   result.ref_types[1].ref_type_name   #=> "Player Trading"
        #   . . .
        def ref_types
          response = request(:eve, :ref_types)
          result = {}
          response.ref_types.each do |row|
            result[row.ref_type_id] = row.ref_type_name
          end
          result
        end

        # Character ID to Name conversion. Accepts a list of character names, and returns the name for each name
        # in the form of a Hash. Despite the name, it can also accept corporation and alliance names.
        def character_id(*names)
          response = request(:eve, :character_id, :names => names.flatten.join(','))
          result = {}
          [:characters, :corporations, :alliances].each do |field|
            if response.respond_to?(field)
              response.send(field).each { |row| result[row.name] = row.character_id }
            end
          end
          result
        end

        # Character ID to Name conversion. Accepts a list of character IDs, and returns the name for each ID
        # in the form of a Hash. Despite the name, it can also accept corporation and alliance IDs.
        def character_name(*ids)
          response = request(:eve, :character_name, :ids => ids.flatten.join(','))
          result = {}
          [:characters, :corporations, :alliances].each do |field|
            if response.respond_to?(field)
              response.send(field).each { |row| result[row.name] = row.name }
            end
          end
          result
        end

        alias character_ids character_id
        alias corporation_ids character_id
        alias corporation_id character_id
        alias corporation_ids character_id
        alias alliance_ids character_id
        alias alliance_id character_id

        alias character_names character_name
        alias corporation_names character_names
        alias corporation_name character_name
        alias corporation_names character_names
        alias alliance_names character_names
        alias alliance_name character_name

        alias factional_warfare_stats fac_war_stats
        alias factional_warfare_top100 fac_war_top_stats
      end
    end
  end
end
