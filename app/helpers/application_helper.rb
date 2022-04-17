module ApplicationHelper
  def button_class
    "mt-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
  end

  def dropdown_ring
    result = <<~CSS
      w-12 my-2 mr-2 p-1
      border border-black rounded-full
      text-center text-lg
      hover:bg-gray-400 focus:bg-gray-400"
    CSS
    result.squish
  end

  FONT_SIZES = {xs: "xs", sm: "base", md: "xl", lg: "3xl", xl: "5xl"}.with_indifferent_access
  def font_size_from(size) = "text-#{FONT_SIZES[size]}"

  NEXT_LABELS = {started: "Finish", unstarted: "Start", attic: "Add"}.with_indifferent_access

  def next_label(status) = NEXT_LABELS[status]

  PREVIOUS_LABELS = {done: "Unfinish", started: "Unstart", unstarted: "Remove"}.with_indifferent_access

  def previous_label(status) = PREVIOUS_LABELS[status]

  def new_button_class
    result = <<~CSS
      font-bold float-right
      rounded-md ring-2 ring-black ring-stone-700
      bg-stone-200 px-4 hover:bg-stone-500
    CSS
    result.squish
  end
end
