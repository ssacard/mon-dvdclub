module ActionView
  module Helpers
    module DateHelper
      def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false)
        from_time = from_time.to_time if from_time.respond_to?(:to_time)
        to_time = to_time.to_time if to_time.respond_to?(:to_time)
        distance_in_minutes = (((to_time - from_time).abs)/60).round
        distance_in_seconds = ((to_time - from_time).abs).round

        case distance_in_minutes
          when 0..1
            return (distance_in_minutes == 0) ? 'il a y moins d\'une minute' : 'il y a une minute' unless include_seconds
            case distance_in_seconds
              when 0..4   then 'il y a moins de 5 secondes'
              when 5..9   then 'il y a moins de 10 secondes'
              when 10..19 then 'il y a moins de 20 secondes'
              when 20..39 then 'il y a 30 secondes'
              when 40..59 then 'il a y moins d\'une minute'
              else             'il a y une minute'
            end

          when 2..44           then "il y a #{distance_in_minutes} minutes"
          when 45..89          then 'il y a environ une heure'
          when 90..1439        then "il y a environ #{(distance_in_minutes.to_f / 60.0).round} heures"
          when 1440..2879      then 'il y a un jour environ'
          when 2880..43199     then "il y a #{(distance_in_minutes / 1440).round} jours"
          when 43200..86399    then 'il y a un mois environ'
          when 86400..525599   then "il y a #{(distance_in_minutes / 43200).round} mois"
          when 525600..1051199 then 'il y a un n environ'
          else                      "il y a plus de #{(distance_in_minutes / 525600).round} ans"
        end
      end
    end
  end
end

