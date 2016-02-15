# "Good Enough" Geoid

[![Build Status](https://travis-ci.org/code-lever/good-enough-geoid-elixir.svg?branch=master "Build Status")](https://travis-ci.org/code-lever/good-enough-geoid-elixir)
[![Hex Version](https://img.shields.io/hexpm/v/good_enough_geoid.svg "Hex Version")](https://hex.pm/packages/good_enough_geoid)

Elixir library that uses pre-generated EGM96-5 data (from [GeographicLib](http://geographiclib.sourceforge.net)'s Geoid class) to get geoid heights that are kinda ok, just good enough.

Results should be similar to those that [GeoidEval](http://geographiclib.sourceforge.net/cgi-bin/GeoidEval) would give you.

Data is currently sampled at 1-degree increments, not great, but good enough.  Enhancements for alternate resolutions, datasets and interpolation would be pretty neat!

## Installation

Add good_enough_geoid to your list of dependencies in `mix.exs` and make sure it's started:

    def application do
      [applications: [:good_enough_geoid]]
    end

    def deps do
      [{:good_enough_geoid, "~> 0.0.1"}]
    end

## Usage

    iex> GoodEnoughGeoid.EGM96_5.height(14.013881, 54.140029)
    -33.699
