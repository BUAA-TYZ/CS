#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* your code here */
    node *fast = head;
    node *slow = head;
    do {
        if (fast && fast->next) {
            fast = fast->next->next;
        } else {
            return 0;
        }
        slow = slow->next;
    } while (fast != slow);
    return 1;
}