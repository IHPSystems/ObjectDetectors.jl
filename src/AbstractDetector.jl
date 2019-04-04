import Base: (+), (/)

export AbstractDetector,
       detect,
       Detection,
       Point,
       (+),
       (/),
       weighted_mean

abstract type AbstractDetector end

struct Point
    row::UInt32
    col::UInt32
end

function (+)(p1::Point, p2::Point)::Point
    return Point(p1.row + p2.row, p1.col + p2.col)
end


function (/)(p1::Point, denum::Number)::Point
    return Point(
        convert(UInt32, round(convert(Float64, p1.row) / denum)),
        convert(UInt32, round(convert(Float64, p1.col) / denum)))
end

function weighted_mean(polygon::Array{Point, 1}) :: Point
    return reduce((+), polygon) / length(polygon)
end

mutable struct Detection
    polygon::Vector{Point}
    class::Int32
    confidence::Float32
end

detect(detector::AbstractDetector, image)::Vector{Detection} = error("No implementation for $(typeof(detector))")
