module ReportsHelper
  def calculate_percentage(actual, total)
    ((actual.to_f / total.to_f) * 100).round(2)
  end
end
