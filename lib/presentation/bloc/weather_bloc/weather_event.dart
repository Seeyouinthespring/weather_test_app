sealed class WeatherEvent{
  const WeatherEvent();
}

class OnInit extends WeatherEvent{
  const OnInit();
}

class OnRefresh extends WeatherEvent{
  const OnRefresh();
}

class OnSelectSection extends WeatherEvent{
  const OnSelectSection();
}