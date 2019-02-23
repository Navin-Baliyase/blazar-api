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
    @graph = Graph.where('PI BETWEEN ? AND ?', min, max)
    render json: {
        x_axis: @graph.pluck(:name),
        y_axis: @graph.pluck(:PI),
        #min: min,
        #max: max,
        #interval: interval,
        #average: average
        #value: @graph
    }.to_json
=end


    @graphs = Graph.all
    min = Graph.minimum(:PI)
    max = Graph.maximum(:PI)
    name = Graph.pluck(:PI).sort
    interval = (max-min+1)/10
    dup_min = min
    dup_interval = interval
    result_string = "(PI >= #{dup_min} AND PI <= #{dup_interval})"
    range = ["#{dup_min}-#{dup_interval}"]
    begin
      dup_min = dup_interval
       dup_interval = dup_interval + (dup_interval-min)
       result_string =+ result_string + " OR (PI >= #{dup_min} AND PI <= #{dup_interval})"
        range << "#{dup_min}-#{dup_interval}"
    end while dup_interval < max
     @graph = Graph.where(result_string).group(:PI)
    render json: {
        X_axis: range,
        Y_axis: @graph.count
    }.to_json

  end
end
