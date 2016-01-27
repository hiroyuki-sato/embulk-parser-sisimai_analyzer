module Embulk
  module Parser

    class SisimaiAnalyzer < ParserPlugin
      Plugin.register_parser("sisimai_analyzer", self)

      def self.transaction(config, &control)
        # configuration code:
        task = {
          "option1" => config.param("option1", :integer),                     # integer, required
          "option2" => config.param("option2", :string, default: "myvalue"),  # string, optional
          "option3" => config.param("option3", :string, default: nil),        # string, optional
        }

        columns = [
          Column.new(0, "example", :string),
          Column.new(1, "column", :long),
          Column.new(2, "name", :double),
        ]

        yield(task, columns)
      end

      def init
        # initialization code:
        @option1 = task["option1"]
        @option2 = task["option2"]
        @option3 = task["option3"]
      end

      def run(file_input)
        while file = file_input.next_file
          file.each do |buffer|
            # parsering code
            record = ["col1", 2, 3.0]
            page_builder.add(record)
          end
        end
        page_builder.finish
      end
    end

  end
end
