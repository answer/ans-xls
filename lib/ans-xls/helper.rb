module Ans::Xls::Helper

  def xls_column(type,style={})
    attrs = {
      "ss:StyleID" => "s#{type}",
    }
    case type
    when "Number"
      attrs["ss:AutoFitWidth"] = 1
    end

    if style[:width]
      attrs["ss:Width"] = style[:width]
    end
    if style[:is_auto_fit_width]
      attrs["ss:AutoFitWidth"] = 1
    end
    content_tag :Column, "", attrs
  end

  def xls_data(type,data)
    xls_type = case type
    when "Text"
      "String"
    else
      type
    end
    content_tag :Data, data, "ss:Type" => xls_type
  end

end
