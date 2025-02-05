# Data Analysis for Ramsauer-Townsend Experiment.
#include("C:/Users/anish/Documents/GitHub/RamsauerTownsend/data")
using DelimitedFiles, CairoMakie
using LaTeXStrings
include("C:/Users/anish/Documents/GitHub/genecorrelations/ThemeColors.jl")
using .ThemeColors

begin
    function loaddir(dir)
        data = [];
        for t in readdir(dir)
            tm = readdlm(joinpath(dir, t),'\t', Float64, '\n')
            push!(data, tm)
        end
        return data
    end
end

begin
    heated_data =  loaddir("data/heated")
    frozen = loaddir("data/frozen")
    
    trial1 = heated_data[1]
end

begin
    # Analyzing and plotting a single trial:
    accelerating_voltage = trial1[:,1]
    plate_current = trial1[:,2]
    shield_current = trial1[:,3]


    # Plot the Accelerating voltage versus Plate voltage
    fig = Figure(fonts=(; sci="CMU Serif"), size = (700, 500), textcolor=fontcolor)

    plot1 = fig[1, 1]

    b_x_label = L"$V_{\text{a}}$"
    b_y_label = L"I_{\text{plate}}\,\,\,\,\, \left[\mu \text{A} \right]"

    ax = CairoMakie.Axis(plot1,
        xlabel=b_x_label, ylabel=b_y_label, xlabelsize=30, ylabelsize=30, xticklabelsize=20, yticklabelsize=20, title=L"\text{ }",
        xticklabelfont=:sci, yticklabelfont=:sci, titlesize=27, aspect = 1, xtickcolor= fontcolor, xticklabelcolor = fontcolor, ytickcolor=fontcolor, yticklabelcolor = fontcolor, 
        bottomspinecolor=fontcolor, leftspinecolor=fontcolor, rightspinecolor=fontcolor,topspinecolor=fontcolor, titlecolor=fontcolor, xlabelcolor =fontcolor,
        ylabelcolor =fontcolor, xgridvisible = false, ygridvisible = false, ytickformat = values -> [(LaTeXString(string(round(value, digits=2)))) for value in values], xtickformat = values -> [(LaTeXString(string((value)))) for value in values],)

    xlims!(0.0, 5.0)
    ylims!(-0.01,1.5)
    th1 = CairoMakie.scatter!(ax, (accelerating_voltage), -plate_current * 1e6,   markersize=5, color=:transparent, strokewidth=1.0, strokecolor=prussian_blue)
    save("raw_voltage.png", fig)

   
end

