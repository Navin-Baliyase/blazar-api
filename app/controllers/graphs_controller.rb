class GraphsController < ApplicationController
	skip_before_action :authenticate_user!

	def index
=begin
    #render json: Graph.all
    @graphs = Graph.all
    min = Graph.minimum(:PI)
    max = Graph.maximum(:PI)
    average = Graph.average(:PI)
    interval = (max-min+1)/@graphs.count
    #current_value = min
    #[[6,7.8],[7.8,]]
    @graph = Graph.where('PI BETWEEN ? AND ?', 6, 7.8)
    render json: {
        x_axis: @graph.pluck(:name),
        y_axis: @graph.pluck(:PI),
        min: min,
        max: max,
        interval: interval,
        average: average
        #value: @graph
    }.to_json
=end

    @graphs = Graph.all
    min = Graph.minimum(:PI)
    max = Graph.maximum(:PI)
    name = Graph.pluck(:PI).sort
    interval = (max-min+1)/@graphs.count
    dup_min = min
    dup_interval = interval
    result_string = "(PI >= #{dup_min} AND PI <= #{dup_interval})"
    ab = ["#{dup_min}..#{dup_min+dup_interval}"]
    begin
      result_string =+ result_string + " OR (PI >= #{dup_min} AND PI <= #{dup_interval})"
      dup_min = dup_interval
      # dup_interval = dup_interval + (dup_interval-min)
      ab << "#{dup_min}..#{dup_interval}"
    end while dup_interval < max
    p result_string
    # @graph = Graph.where(result_string).group(:name)
    render json: {
        x_axis: ab,
        name: name
        #min: min,
        #max: max,
        #interval: interval,
        #value: @graph.pluck(:PI),
    }.to_json


  end

end
