class ReactionService {
  static Map<String, dynamic>? checkReaction(String subA, String subB) {
    // 1. Phản ứng trung hòa: Axit + Bazơ
    if ((subA == "HCl" && subB == "NaOH") ||
        (subA == "NaOH" && subB == "HCl")) {
      return {
        "equation": "\$HCl + NaOH \\rightarrow NaCl + H_2O\$",
        "phenomenon": "Phản ứng tỏa nhiệt, không có kết tủa.",
        "color": "transparent",
        "videoUrl": "https://www.youtube.com/watch?v=HQfXzbZJhgg",
      };
    }
    // 2. Phản ứng tạo kết tủa: Muối + Axit
    if ((subA == "BaCl2" && subB == "H2SO4") ||
        (subA == "H2SO4" && subB == "BaCl2")) {
      return {
        "equation":
            "\$BaCl_2 + H_2SO_4 \\rightarrow BaSO_4 \\downarrow + 2HCl\$",
        "phenomenon": "Xuất hiện kết tủa trắng tinh khiết.",
        "color": "white",
        "videoUrl": "https://www.youtube.com/watch?v=HQfXzbZJhgg",
      };
    }
    // 3. Phản ứng nhận biết: Axit + Quỳ tím
    if ((subA == "Quỳ tím" && subB == "HCl") ||
        (subA == "HCl" && subB == "Quỳ tím")) {
      return {
        "equation": "Axit làm quỳ tím hóa đỏ",
        "phenomenon": "Giấy quỳ tím chuyển sang màu đỏ rực.",
        "color": "red",
        "videoUrl": "https://www.youtube.com/watch?v=HQfXzbZJhgg",
      };
    }
    return null; // Không có phản ứng xảy ra
  }
}
