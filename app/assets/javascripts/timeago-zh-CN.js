(function (factory) {
  if (typeof define === 'function' && define.amd) {
    define(['jquery'], factory);
  } else if (typeof module === 'object' && typeof module.exports === 'object') {
    factory(require('jquery'));
  } else {
    factory(jQuery);
  }
}(function (jQuery) {
  jQuery.timeago.settings.strings["zh-CN"] = {
    prefixAgo: null,
    prefixFromNow: "从现在开始",
    suffixAgo: "前",
    suffixFromNow: null,
    seconds: "不到1分钟",
    minute: "约1分钟",
    minutes: "%d分钟",
    hour: "约1小时",
    hours: "约%d小时",
    day: "1天",
    days: "%d天",
    month: "约1个月",
    months: "%d月",
    year: "约1年",
    years: "%d年",
    numbers: [],
    wordSeparator: ""
  };
}));
