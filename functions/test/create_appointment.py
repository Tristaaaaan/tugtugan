# logic.py
from datetime import datetime, timezone, date

def get_availability_logic(studio_id, year, month, availability_data):
    """
    Pure logic function - no Firebase dependencies
    availability_data = list of dicts with 'date' key
    """
    
    # Validate parameters
    if not studio_id:
        raise ValueError("studioId is required")
    
    if not isinstance(year, int):
        raise ValueError("year must be an integer")
    
    if not isinstance(month, int) or not 1 <= month <= 12:
        raise ValueError("month must be between 1 and 12")
    
    # Get current UTC date
    now_utc = datetime.now(timezone.utc)
    today_utc = now_utc.date()
    
    # Determine requested month's boundaries
    first_day = date(year, month, 1)
    
    if month == 12:
        next_month = date(year + 1, 1, 1)
    else:
        next_month = date(year, month + 1, 1)
    
    # Month is in the past
    if next_month <= today_utc:
        return []
    
    # Start from today for current month
    start_date = max(first_day, today_utc)
    
    # Filter availability to this month
    filtered = []
    current_date = start_date
    
    while current_date < next_month:
        document_id = current_date.strftime("%Y-%m-%d")
        
        # Find matching availability
        match = next((a for a in availability_data if a.get("date") == document_id), None)
        if match:
            filtered.append(match)
        
        current_date = date.fromordinal(current_date.toordinal() + 1)
    
    return filtered


# Test data
mock_availability = [
    {"date": "2026-08-21", "slots": [...]},
    {"date": "2026-08-22", "slots": [...]},
]

# Test
result = get_availability_logic("studio-123", 2026, 8, mock_availability)
print(f"Result: {result}")
print(f"Length: {len(result)}")