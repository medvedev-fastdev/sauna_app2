function initCalendar() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	
	$('#calendar').fullCalendar({
		editable: false,        
		header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        defaultView: 'month',
        height: 300,
        slotMinutes: 30,
		allDaySlot : false,
        timeFormat: 'H:mm { - H:mm} ',
		selectable: true,
		selectHelper: true,
   
        eventSources: [{
            url: '/bookings',
            color: 'yellow',
            textColor: 'black',
            ignoreTimezone: false
        }],
        		
		dayClick: function(date, allDay, jsEvent, view) {
		   $('#calendar').fullCalendar('gotoDate', date);
		   $('#calendar').fullCalendar('changeView', 'agendaDay');
        },
		
		select: function(start, end, allDay) {
			$('#calendar').fullCalendar('removeEvents');
			
			var title="Бронирование";
			if (title) {
				var eventObj = 	{
					title: title,
					start: start,
					end: end,
					allDay: allDay
				};
				$('#calendar').fullCalendar('renderEvent', eventObj, true);
			}
			$('#calendar').fullCalendar('unselect');
		}
	});
}