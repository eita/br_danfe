module BrDanfe
  module DanfeLib
    class Helper
      def self.numerify(number, decimals = 2)
        return "" if !number || number == ""
        int, frac = ("%.#{decimals}f" % number).split(".")
        int.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1\.")
        int + "," + frac
      end

      def self.invert(y)
        28.7.cm - y
      end

      def self.format_datetime(xml_datetime)
        formated = ""

        if !xml_datetime.empty?
          date = DateTime.strptime(xml_datetime, "%Y-%m-%dT%H:%M:%S")
          formated = date.strftime("%d/%m/%Y %H:%M:%S")
        end

        formated
      end

      def self.format_date(xml_datetime)
        formated = ""

        if !xml_datetime.empty?
          date = DateTime.strptime(xml_datetime, "%Y-%m-%d")
          formated = date.strftime("%d/%m/%Y")
        end

        formated
      end

      def self.format_time(xml_datetime)
        formated = ""

        if xml_datetime.length == 8
          formated = xml_datetime
        elsif xml_datetime.length > 8
          date = DateTime.strptime(xml_datetime, "%Y-%m-%dT%H:%M:%S %Z").to_time
          formated = date.strftime("%H:%M:%S")
        end

        formated
      end

      def self.has_no_fiscal_value?(xml)
        homologation?(xml) || unauthorized?(xml)
      end

      private
      def self.homologation?(xml)
        xml.css("nfeProc/NFe/infNFe/ide/tpAmb").text == "2"
      end

      def self.unauthorized?(xml)
        xml.css("nfeProc/protNFe/infProt/dhRecbto").empty?
      end
    end
  end
end
